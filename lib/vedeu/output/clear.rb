module Vedeu

  # Clears all the character data for the area defined by an interface. This
  # class is called every time an interface is rendered to prepare the area
  # for new data.
  class Clear

    # Blanks the area defined by the interface.
    #
    # @param interface [Interface]
    # @return [String]
    def self.call(interface)
      new(interface).clear
    end

    # Returns a new instance of Clear.
    #
    # @param interface [Interface]
    # @return [Clear]
    def initialize(interface)
      @interface = interface
    end

    # @return [String]
    def clear
      rows.inject([colours]) do |line, index|
        line << interface.origin(index) { ' ' * interface.viewport_width }
      end.join
    end

    private

    attr_reader :interface

    # @api private
    # @return [String]
    def colours
      interface.colour.to_s
    end

    # @api private
    # @return [Enumerator]
    def rows
      interface.viewport_height.times
    end

  end
end
