module Vedeu
  class Clear
    def self.call(interface)
      new(interface).clear
    end

    def initialize(interface)
      @interface = interface
    end

    def clear
      interface_lines.inject([colours]) do |line, index|
        line << interface.geometry.origin(index)
        line << ' ' * interface.geometry.width
        line << interface.geometry.origin(index)
      end.join
    end

    private

    attr_reader :interface

    def colours
      interface.colour.to_s
    end

    def interface_lines
      interface.geometry.height.times
    end
  end
end
