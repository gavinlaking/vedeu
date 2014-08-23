module Vedeu
  class Clear
    def self.call(interface)
      new(interface).clear
    end

    def initialize(interface)
      @interface = interface
    end

    def clear
      rows.inject([colours]) do |line, index|
        line << interface.origin(index) { ' ' * interface.viewport_width }
      end.join
    end

    private

    attr_reader :interface

    def colours
      interface.colour.to_s
    end

    def rows
      interface.viewport_height.times
    end
  end
end
