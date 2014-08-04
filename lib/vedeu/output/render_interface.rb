module Vedeu
  class RenderInterface
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
      processed_lines = lines.map do |line|
        if line.streams.any?
          processed_streams = []
          line_length       = 0
          line.streams.each do |stream|
            next if stream.text.empty?

            if (line_length += stream.text.size) >= width
              remainder = width - line_length

              processed_streams << Stream.new(
                                    text:   truncate(stream.text, remainder),
                                    style:  stream.style,
                                    colour: stream.colour)

            else
              processed_streams << stream

            end
          end

          Line.new(streams: processed_streams,
                   style:   line.style,
                   colour:  line.colour)
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
      interface.geometry.height
    end

    def width
      interface.geometry.width
    end
  end
end
