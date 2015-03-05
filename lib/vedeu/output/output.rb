module Vedeu

  # Sends the interface to the terminal or output device.
  #
  class Output

    # Clears the area defined by the interface.
    #
    # @return [Array|String]
    # @see #initialize
    def self.clear(interface)
      new(interface).clear
    end

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

    # Clear the view and send to the terminal.
    #
    # @return [Array]
    def clear
      if Vedeu::Configuration.drb?
        Vedeu.trigger(:_drb_store_output_, virtual_clear)

        HTMLRenderer.to_file(VirtualBuffer.retrieve)
      end

      Terminal.output(Renderer.render(virtual_clear))
    end

    # Send the view to the terminal.
    #
    # @return [Array]
    def render
      if Vedeu::Configuration.drb?
        Vedeu.trigger(:_drb_store_output_, virtual_view)

        HTMLRenderer.to_file(VirtualBuffer.retrieve)
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
          row << if char.is_a?(Vedeu::Char) && (char.x != ix || char.y != iy)
            char.position = origin(iy, ix)
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

    # @param value [String]
    # @param iy [Fixnum]
    # @param ix [Fixnum]
    # @return [Vedeu::Char]
    def char_builder(value, iy, ix)
      Vedeu::Char.new({ value:    value,
                        colour:   interface.colour,
                        style:    interface.style,
                        position: origin(iy, ix) })
    end

    # Returns the position of the cursor at the top-left coordinate, relative to
    # the interface's position.
    #
    # @param y_index [Fixnum]
    # @param x_index [Fixnum]
    # @return [Vedeu::Position]
    def origin(y_index = 0, x_index = 0)
      Vedeu::Position.new(virtual_y[y_index], virtual_x[x_index])
    end

    # Provides a virtual y position within the interface's dimensions.
    #
    # @example
    #   # top = 3
    #   # bottom = 6
    #   # virtual_y # => [3, 4, 5]
    #
    # @return [Array]
    def virtual_y
      @virtual_y ||= (interface.top...interface.bottom).to_a
    end

    # Provides a virtual x position within the interface's dimensions.
    #
    # @example
    #   # left = 9
    #   # right = 13
    #   # virtual_x # => [9, 10, 11, 12]
    #
    # @return [Array]
    def virtual_x
      @virtual_x ||= (interface.left...interface.right).to_a
    end

  end # Output

end # Vedeu
