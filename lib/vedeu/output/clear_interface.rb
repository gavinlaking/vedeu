module Vedeu
  class ClearInterface
    def self.call(interface)
      new(interface).clear
    end

    def initialize(interface)
      @interface = interface
    end

    def clear
      set_colour + clear_lines
    end

    private

    attr_reader :interface

    def set_colour
      interface.colour.to_s
    end

    def clear_lines
      interface.height.times.inject([]) do |line, index|
        line << clear_line(index)
      end.join
    end

    def clear_line(index)
      interface.origin(index) +
      (' ' * interface.width) +
      interface.origin(index)
    end
  end
end
