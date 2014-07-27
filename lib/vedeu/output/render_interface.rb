require 'vedeu/output/clear_interface'

module Vedeu
  class RenderInterface
    def self.call(interface)
      new(interface).render
    end

    def initialize(interface)
      @interface = interface
    end

    def render
      out = [ClearInterface.call(interface)]
      processed_lines.each_with_index do |line, index|
        if index + 1 <= height
          out << interface.origin(index)
          out << line.to_s
        end
      end
      out.join
    end

    private

    attr_reader :interface

    def processed_lines
      lines.each_with_index do |line|
        if line.streams.any?
          processed_streams = []
          line_length       = 0
          line.streams.each do |stream|
            next if stream.text.empty?

            if (line_length += stream.text.size) >= width
              remainder = width - line_length
              stream.text = truncate(stream.text, remainder)
            end

            processed_streams << stream
          end

          line.streams = processed_streams
        end
      end
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
