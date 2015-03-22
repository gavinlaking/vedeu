require 'vedeu/output/html_renderer'
require 'vedeu/output/renderer'
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

    # Return a new instance of Vedeu::Output.
    #
    # @param interface [Interface]
    # @return [Output]
    def initialize(interface)
      @interface = interface
    end

    # Send the view to the terminal.
    #
    # @return [Array<Array<Vedeu::Char>>]
    def render
      if Vedeu::Configuration.drb?
        Vedeu.trigger(:_drb_store_output_, interface.render)

        Vedeu::HTMLRenderer.to_file(Vedeu::VirtualBuffer.retrieve)
      end

      Vedeu::Terminal.output(Vedeu::Esc.string(:hide_cursor))
      output = Vedeu::Terminal.output(Vedeu::Renderer.render(interface.render))
      Vedeu::Terminal.output(Vedeu::Esc.string(:show_cursor))
      output
    end

    private

    # @!attribute [r] interface
    # @return [Interface]
    attr_reader :interface

  end # Output

end # Vedeu
