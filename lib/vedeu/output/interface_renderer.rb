module Vedeu
  class InterfaceRenderer
    def self.clear(interface)
      new(interface).clear
    end

    def self.render(interface)
      new(interface).render
    end

    def initialize(interface)
      @interface = interface
    end

    def clear
      set_colour + clear_lines
    end

    def render
      out = []
      content_lines.each_with_index do |line, index|
        out << origin(index)
        out << line.to_s
      end
      out.join
    end

    private

    attr_reader :interface

    def content_lines
      interface.lines
    end

    def set_colour
      interface.colour.to_s
    end

    def clear_lines
      height.times.inject([]) { |line, index| line << clear_line(index) }.join
    end

    def clear_line(index)
      origin(index) + (' ' * width) + origin(index)
    end

    def origin(index)
      interface.origin(index)
    end

    def height
      interface.height
    end

    def width
      interface.width
    end
  end
end
