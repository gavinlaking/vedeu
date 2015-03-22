module Vedeu

  # Clears the area defined by an interface.
  #
  class Clear

    class << self

      # Clears the area defined by the interface.
      #
      # @return [Array|String]
      # @see #initialize
      def clear(interface)
        new(interface).write
      end
      alias_method :render, :clear

    end

    # Return a new instance of Output.
    #
    # @param interface [Interface]
    # @return [Output]
    def initialize(interface)
      @interface = interface
    end

    # For each visible line of the interface, set the foreground and background
    # colours to those specified when the interface was defined, then starting
    # write space characters over the area which the interface occupies.
    #
    # @return [Array<Array<Vedeu::Char>>]
    def clear
      if interface.height == Terminal.height &&
         interface.width == Terminal.width

        [
          [
            interface.colour.to_s,
            "\e[2J",
            "\e[1;1H"
          ]
        ]

      else
        rows = [interface.colour.to_s]
        interface.height.times do |iy|
          cols = []
          interface.width.times do |ix|
            cols << Vedeu::IndexPosition[iy, ix, interface.top, interface.left].to_s { ' ' }

            # Build Char objects for VirtualTerminal/VirtualBuffer.
            # Vedeu::Char.new({ value:    ' ',
            #                   colour:   interface.colour,
            #                   style:    interface.style,
            #                   position: Vedeu::IndexPosition[iy, ix, interface.top, interface.left] })
          end
          rows << cols
        end
        rows << interface.top_left.to_s
        rows
      end
    end

    # Clear the view and send to the terminal.
    #
    # @return [Array]
    def write
      Vedeu.log(type: :output, message: "Clearing: '#{interface.name}'")

      if Vedeu::Configuration.drb?
        Vedeu.trigger(:_drb_store_output_, clear)

        Vedeu::HTMLRenderer.to_file(Vedeu::VirtualBuffer.retrieve)
      end

      Vedeu::Terminal.output(Vedeu::Renderer.render(clear))
    end

    private

    # @!attribute [r] interface
    # @return [Interface]
    attr_reader :interface

  end # Clear

end # Vedeu

