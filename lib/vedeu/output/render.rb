module Vedeu
  class Render

    # @param interface [Interface]
    # @return [String]
    def self.call(interface)
      new(interface).render
    end

    # @param interface [Interface]
    # @return [Render]
    def initialize(interface)
      @interface = interface
    end

    # @return [String]
    def render
      out = [ Clear.call(interface) ]
      processed_lines.each_with_index do |line, index|
        if index + 1 <= height
          out << interface.origin(index)
          out << line.to_s
        end
      end
      out << interface.cursor
      out.join
    end

    private

    attr_reader :interface

    # The client application may have created a line that us too long for the
    # interface. This code tries to truncate streams whilst preserving styles
    # and colours.
    def processed_lines
      return [] unless lines.any? { |line| line.streams.any? }

      lines.map do |line|
        if exceeds_width?(line)
          line_length = 0
          processed   = []
          line.streams.each do |stream|
            next if stream.text.empty?

            if (line_length += stream.text.size) >= width
              remainder = width - line_length

              processed << Stream.new({
                             colour: stream.colour.attributes,
                             style:  stream.style.values,
                             text:   truncate(stream.text, remainder),
                           })

            else
              processed << stream

            end
          end

          Line.new({
            colour:  line.colour.attributes,
            streams: processed,
            style:   line.style.values,
          })

        else
          line

        end
      end
    end

    def exceeds_width?(line)
      content = line.streams.map(&:text).join
      content.size > width
    end

    def truncate(text, value)
      text.chomp.slice(0...value)
    end

    def lines
      interface.lines
    end

    def height
      interface.viewport_height
    end

    def width
      interface.viewport_width
    end

  end
end
