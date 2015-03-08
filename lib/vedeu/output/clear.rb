module Vedeu

  # Clears the area defined by an interface.
  #
  class Clear

    include Vedeu::CharBuilder

    # Clears the area defined by the interface.
    #
    # @return [Array|String]
    # @see #initialize
    def self.clear(interface)
      new(interface).write
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
      out = rows.times.inject([]) do |row, iy|
        row << columns.times.inject([]) do |col, ix|
          col << char_builder(' ', iy, ix)
        end
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

    # @return [Fixnum]
    def rows
      interface.height
    end

    # @return [Fixnum]
    def columns
      interface.width
    end

  end # Clear

end # Vedeu

