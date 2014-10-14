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
    # @param interface [Interface]
    # @return [String]
    def self.call(interface)
      new(interface).render
    end

    # Return a new instance of Render.
    #
    # @param interface [Interface]
    # @return [Render]
    def initialize(interface)
      @interface = interface
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
      out << interface.cursor.to_s if interface.in_focus?
      out.join
    end

    private

    attr_reader :interface, :options

    # The client application may have created a line that us too long for the
    # interface. This code tries to truncate streams whilst preserving styles
    # and colours. To achieve this, it successively checks each stream length
    # against remaining line length and truncates the stream data if it
    # exceeds the line length. Further stream data that does not fit is
    # discarded.
    #
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
    # @param line [Line]
    # @return [Boolean]
    def exceeds_width?(line)
      line.streams.map(&:content).join.size > width
    end

    # Truncates the provided string.
    #
    # @param string [String] The string to be truncated.
    # @param value [Fixnum] The total length of the string after truncation.
    # @return [String]
    def truncate(string, value)
      string.chomp.slice(0...value)
    end

    # Provides the collection of visible lines associated with the interface.
    #
    # @return [Array]
    def visible_lines
      @visible_lines ||= viewport.visible_lines
    end

    # Provides the visible area of the content within the interface.
    #
    # @return [Viewport]
    def viewport
      interface.viewport
    end

    # Provides the currently available width of the interface.
    #
    # @return [Fixnum]
    def width
      interface.width
    end

  end # Render

end # Vedeu
