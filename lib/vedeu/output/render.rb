module Vedeu

  # Attempts to convert the provided interface object with associated lines,
  # streams, colours, styles, etc, into a single string containing all content
  # and escape sequences.
  #
  # @api private
  class Render

    # Create a new instance of Render with the provided {Vedeu::Interface} and
    # then convert the interface into a single string of content and escape
    # sequences.
    #
    # @api private
    # @param interface [Interface]
    # @param options [Hash]
    # @return [String]
    def self.call(interface, options = {})
      new(interface, options).render
    end

    # Return a new instance of Render.
    #
    # @param interface [Interface]
    # @param options [Hash]
    # @return [Render]
    def initialize(interface, options = {})
      @interface = interface
      @options   = options
    end

    # Produces a single string which contains all content and escape sequences
    # required to render this interface to a position in the terminal window.
    #
    # @return [String]
    def render
      Vedeu.log("Rendering view: '#{interface.name}'")

      out = [ Clear.call(interface) ]
      processed_lines.each_with_index do |line, index|
        out << interface.origin(index)
        out << line.to_s
      end
      out.join
    end

    private

    attr_reader :interface

    # The client application may have created a line that us too long for the
    # interface. This code tries to truncate streams whilst preserving styles
    # and colours. To achieve this, it successively checks each stream length
    # against remaining line length and truncates the stream data if it
    # exceeds the line length. Further stream data that does not fit is
    # discarded.
    #
    # @api private
    # @return [Array]
    def processed_lines
      return [] unless visible_lines.any? { |line| line.streams.any? }

      visible_lines.map do |line|
        if exceeds_width?(line)
          line_length = 0
          new_streams = []

          new_streams = line.streams.map do |stream|
            next if stream.content.empty?

            if (line_length += stream.content.size) >= width
              remainder = width - line_length
              truncated = truncate(stream.content, remainder)

              build_stream(line, stream, truncated)

            else
              stream

            end
          end

          build_line(line, new_streams)

        else
          line

        end
      end
    end

    # Builds a new Stream object with the newly truncated text and previous
    # attributes.
    #
    # @api private
    # @param line [Line]
    # @param stream [Stream]
    # @param content [String]
    # @return [Stream]
    def build_stream(line, stream, content)
      attributes = stream.view_attributes.merge!({
        parent: line.view_attributes,
        text:   content,
      })

      Stream.new(attributes)
    end

    # Builds a new Line object with the new streams and previous attributes.
    #
    # @api private
    # @param line [Line]
    # @param streams [Array]
    # @return [Line]
    def build_line(line, streams)
      attributes = line.view_attributes.merge!({
        parent:  interface.view_attributes,
        streams: streams,
      })

      Line.new(attributes)
    end

    # Converts all streams within a line into a single line of text to then
    # check that this line (without formatting, as that is not visible) exceeds
    # the width of the interface.
    #
    # @api private
    # @param line [Line]
    # @return [Boolean]
    def exceeds_width?(line)
      line.streams.map(&:content).join.size > width
    end

    # Truncates the provided string.
    #
    # @api private
    # @param string [String] The string to be truncated.
    # @param value [Fixnum] The total length of the string after truncation.
    # @return [String]
    def truncate(string, value)
      string.chomp.slice(0...value)
    end

    # Provides the collection of visible lines associated with the interface.
    # If the option `:top` was set, we will start at that line. Any lines
    # outside of the height will not be rendered.
    #
    # @api private
    # @return [Array]
    def visible_lines
      lines[top..height]
    end

    # Provides the collection of lines associated with the interface.
    #
    # @api private
    # @return [Array]
    def lines
      interface.lines
    end

    # Provides the currently available height of the interface.
    #
    # @note The height is reported to be one less line than actual because
    #   terminal coordinates count from 1, not 0.
    #
    # @api private
    # @return [Fixnum]
    def height
      interface.viewport_height - 1
    end

    # Provides the currently available width of the interface.
    #
    # @api private
    # @return [Fixnum]
    def width
      interface.viewport_width
    end

    # The current top line.
    #
    # @api private
    # @return [Fixnum]
    def top
      options[:top]
    end

    # @api private
    # @return [Hash]
    def options
      @_options ||= defaults.merge!(@options)
    end

    # @api private
    # @return [Hash]
    def defaults
      {
        top: 0
      }
    end

  end # Render

end # Vedeu
