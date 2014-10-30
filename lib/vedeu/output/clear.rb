module Vedeu

  # Clears all the character data for the area defined by an interface. This
  # class is called every time an interface is rendered to prepare the area
  # for new data.
  #
  # @note We don't simply clear the entire terminal as this would remove the
  #   content of other interfaces which are being displayed.
  #
  # @todo What if an interface 'moves' or changes shape due to the terminal
  #   resizing?
  #
  # @api private
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

    # For each visible line of the interface, set the foreground and background
    # colours to those specified when the interface was defined, then starting
    # write space characters over the area which the interface occupies.
    #
    # @return [String]
    def clear
      Vedeu.log("Clearing view: '#{interface.name}'")

      rows.inject([colours]) do |line, index|
        line << interface.origin(index) { ' ' * interface.width }
      end.join
    end

    private

    attr_reader :interface

    # @return [String]
    def colours
      interface.colour.to_s
    end

    # @return [Enumerator]
    def rows
      interface.height.times
    end

  end # Clear

end # Vedeu
