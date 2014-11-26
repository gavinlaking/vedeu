module Vedeu

  class Output

    # Writes the space character to the area defined by the interface for all
    # visible lines and columns, using the background and foreground colours
    # specified when the interface was defined.
    #
    # @note We don't simply clear the entire terminal as this would remove the
    #   content of other interfaces which are being displayed.
    #
    # @return [Array|String]
    # @see #initialize
    def self.clear(interface, options = {})
      new(interface, options).clear
    end

    # Writes content (the provided interface object with associated lines,
    # streams, colours and styles) to the area defined by the interface.
    #
    # @return [Array|String]
    # @see #initialize
    def self.render(interface, options = {})
      new(interface, options).render
    end

    # Return a new instance of Output.
    #
    # @param interface [Interface]
    # @param options [Hash]
    # @option options :direct [Boolean] Send escape sequences and content
    #   directly to the Terminal.
    # @return [Output]
    def initialize(interface, options = {})
      @interface = interface
      @options   = defaults.merge!(options)
    end

    # Produces a single string which contains all content and escape sequences
    # required to render this interface in the terminal window.
    #
    # @return [String]
    def render
      out = [ Output.clear(interface, { direct: false }) ]

      Vedeu.log("Rendering view: '#{interface.name}'")

      interface.viewport.each_with_index do |line, index|
        out << interface.origin(index)
        out << line.join
      end
      out.join
    end

    # Send the cleared area to the terminal.
    #
    # @return [Array]
    def clear
      return Terminal.output(view) if direct?

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

  end # output

end # Vedeu
