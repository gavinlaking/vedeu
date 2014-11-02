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
    # @param options [Hash]
    # @return [String]
    # @see #initialize
    def self.call(interface, options = {})
      new(interface, options).clear
    end

    # Returns a new instance of Clear.
    #
    # @param interface [Interface]
    # @param options [Hash]
    # @option options :direct [Boolean] Send escape sequences to clear an area
    #   directly to the Terminal.
    # @return [Clear]
    def initialize(interface, options = {})
      @interface = interface
      @options   = defaults.merge!(options)
    end

    # Send the cleared area to the terminal.
    #
    # @return [Array]
    def clear
      return Terminal.output(view) unless direct?

      view
    end

    private

    attr_reader :interface, :options

    # For each visible line of the interface, set the foreground and background
    # colours to those specified when the interface was defined, then starting
    # write space characters over the area which the interface occupies.
    #
    # @return [String]
    def view
      Vedeu.log("Clearing view: '#{interface.name}'")

      rows.inject([colours]) do |line, index|
        line << interface.origin(index) { ' ' * interface.width }
      end.join
    end

    # @return [String]
    def colours
      interface.colour.to_s
    end

    # @return [Enumerator]
    def rows
      interface.height.times
    end

    # @return [Boolean]
    def direct?
      options[:direct]
    end

    # @return [Hash]
    def defaults
      {
        direct: true
      }
    end

  end # Clear

end # Vedeu
