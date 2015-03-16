require 'vedeu/output/clear'
require 'vedeu/output/html_renderer'
require 'vedeu/output/renderer'
require 'vedeu/output/viewport'
require 'vedeu/output/virtual_buffer'
require 'vedeu/support/terminal'

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

        Vedeu::HTMLRenderer.to_file(Vedeu::VirtualBuffer.retrieve)
      end

      Vedeu::Terminal.output(Vedeu::Renderer.render(virtual_view))
    end

    private

    # @!attribute [r] interface
    # @return [Interface]
    attr_reader :interface

    # Builds up a virtual view; a grid of Vedeu::Char objects- each one holding
    # one character along with its colour, style and position attributes.
    #
    # @note
    #   omg!
    #
    # @return [Array<Array<Vedeu::Char>>]
    def virtual_view
      out = [ clear_area_first! ]

      Vedeu.log(type: :output, message: "Rendering: '#{interface.name}'")

      viewport.each_with_index do |line, iy|
        row = []
        line.each_with_index do |char, ix|
          row << if char.x != ix || char.y != iy
            char.position = Vedeu::IndexPosition[iy, ix, interface.top, interface.left]
            char

          else
            char

          end
        end
        out << row
      end
      out
    end

    # @return [Array<Array<Vedeu::Char>>]
    def clear_area_first!
      Vedeu::Clear.new(interface).clear
    end

    # @return [void]
    def viewport
      @viewport ||= Vedeu::Viewport.new(interface).render
    end

  end # Output

end # Vedeu
