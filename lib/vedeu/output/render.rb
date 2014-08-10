require 'vedeu/models/line'
require 'vedeu/models/stream'

module Vedeu
  class Render
    def self.call(interface)
      new(interface).render
    end

    def initialize(interface)
      @interface = interface
    end

    def render
      out = [interface.clear]
      processed_lines.each_with_index do |line, index|
        if index + 1 <= height
          out << interface.origin(index)
          out << line.to_s
          out << interface.origin(index)
        end
      end
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

              processed << Stream.new(text:   truncate(stream.text, remainder),
                                      style:  stream.style,
                                      colour: stream.colour)

            else
              processed << stream

            end
          end

          Line.new(streams: processed, style: line.style, colour: line.colour)
        else
          line
        end
      end
    end

    def exceeds_width?(line)
      content = line.streams.map(&:text)
      content.size > width
    end

    def truncate(text, value)
      text.chomp.slice(0...value)
    end

    def lines
      interface.lines
    end

    def height
      interface.height
    end

    def width
      interface.width
    end
  end
end
