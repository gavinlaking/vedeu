module Vedeu
  class ClearInterface
    def self.call(interface)
      new(interface).clear
    end

    def initialize(interface)
      @interface = interface
    end

    def clear
      interface.height.times.inject([interface.colour.to_s]) do |line, index|
        line << interface.origin(index)
        line << (' ' * interface.width)
        line << interface.origin(index)
      end.join
    end

    private

    attr_reader :interface
  end
end
