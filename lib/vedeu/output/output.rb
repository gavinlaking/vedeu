require 'vedeu/output/renderers/all'
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
    # @return [Array]
    def render
      if Vedeu::Configuration.drb?
        Vedeu.trigger(:_drb_store_output_, rendered)

        Vedeu::HTMLRenderer.to_file(Vedeu::VirtualBuffer.retrieve)
      end

      # Vedeu::FileRenderer.render(rendered)

      Vedeu::TerminalRenderer.render(rendered)
    end

    private

    # @!attribute [r] interface
    # @return [Interface]
    attr_reader :interface

    def rendered
      @rendered ||= interface.render
    end

  end # Output

end # Vedeu
