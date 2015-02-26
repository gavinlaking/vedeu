module Vedeu

  # Sends the interface to the terminal or output device.
  #
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
      if Vedeu::Configuration.drb?
        Vedeu.trigger(:_drb_store_output_, virtual_view)
      end

      Terminal.output(Renderer.render(virtual_view, interface.cursor))
    end

    private

    attr_reader :interface

    # For each visible line of the interface, set the foreground and background
    # colours to those specified when the interface was defined, then starting
    # write space characters over the area which the interface occupies.
    #
    # @note
    #   omg!
    #
    # @return [Array<Array<Vedeu::Char>>]
    def virtual_clear
      Vedeu.log(type: :output, message: "Clearing: '#{interface.name}'")

      out = []
      interface.height.times do |iy|
        row = []
        interface.width.times do |ix|
          row << char_builder(' ', iy, ix)
        end
        out << row
      end
      out
    end

    # Builds up a virtual view; a grid of Vedeu::Char objects- each one holding
    # one character along with its colour, style and position attributes.
    #
    # @note
    #   omg!
    #
    # @return [Array<Array<Vedeu::Char>>]
    def virtual_view
      out = [ virtual_clear ]

      Vedeu.log(type: :output, message: "Rendering: '#{interface.name}'")

      viewport.each_with_index do |line, iy|
        row = []
        line.each_with_index do |char, ix|
          row << if char.is_a?(Vedeu::Char)
            char.position = position(iy, ix)
            char

          else
            char_builder(char, iy, ix)

          end
        end
        out << row
      end
      out
    end

    # @return [void]
    def viewport
      @viewport ||= Vedeu::Viewport.new(interface).render
    end

    # @param iy [Fixnum]
    # @param ix [Fixnum]
    # @return [Vedeu::Position]
    def position(iy, ix)
      interface.origin(iy, ix)
    end

    # @param value [String]
    # @param iy [Fixnum]
    # @param ix [Fixnum]
    # @return [Vedeu::Char]
    def char_builder(value, iy, ix)
      Vedeu::Char.new({ value:    value,
                        colour:   interface.colour,
                        style:    interface.style,
                        position: position(iy, ix) })
    end

  end # Output

end # Vedeu
