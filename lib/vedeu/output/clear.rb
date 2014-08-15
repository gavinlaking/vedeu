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
        line << interface.origin(index) { ' ' * interface.width }
      end.join
    end

    private

    attr_reader :interface

    def colours
      interface.colour.to_s
    end

    def interface_lines
      interface.height.times
    end
  end
end
