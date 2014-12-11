module Vedeu

  class Output

    # Writes content (the provided interface object with associated lines,
    # streams, colours and styles) to the area defined by the interface.
    #
    # @return [Array|String]
    # @see #initialize
    def self.render(interface)
      new(interface).render
    end

    # Return a new instance of Output.
    #
    # @param interface [Interface]
    # @return [Output]
    def initialize(interface)
      @interface = interface
    end

    # Send the view to the terminal.
    #
    # @return [Array]
    def render
      Terminal.output(view, Focus.cursor)
    end

    private

    attr_reader :interface

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

    # @return [String]
    def colours
      interface.colour.to_s
    end

    # @return [Enumerator]
    def rows
      interface.height.times
    end

    # Produces a single string which contains all content and escape sequences
    # required to render this interface in the terminal window.
    #
    # @return [String]
    def view
      out = [ clear ]

      Vedeu.log("Rendering view: '#{interface.name}'")

      interface.viewport.each_with_index do |line, index|
        out << interface.origin(index)
        out << line.join
      end
      out.join
    end

  end # Output

end # Vedeu
