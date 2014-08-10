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
          out << interface.geometry.origin(index)
          out << line.to_s
        end
      end
      out.join
    end

    private

    attr_reader :interface

    def processed_lines
      return [] unless lines.any? { |line| line.streams.any? }

      lines.map do |line|
        line_length = 0
        streams     = line.streams.inject([]) do |processed, stream|
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

        Line.new(streams: streams,
                 style:   line.style,
                 colour:  line.colour)
      end
    end

    def truncate(text, value)
      text.chomp.slice(0...value)
    end

    def lines
      interface.lines
    end

    def height
      interface.geometry.height
    end

    def width
      interface.geometry.width
    end
  end
end
