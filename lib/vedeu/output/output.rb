require 'vedeu/output/renderers/all'
require 'vedeu/output/virtual_buffer'

module Vedeu

  # Sends the content to the renderers.
  class Output

    # Writes content to the defined renderers.
    #
    # @return [Array|String]
    # @see #initialize
    def self.render(content)
      new(content).render
    end

    # Return a new instance of Vedeu::Output.
    #
    # @param content [Array<Array<Vedeu::Char>>]
    # @return [Output]
    def initialize(content)
      @content = content
    end

    # Send the view to the renderers.
    #
    # @return [Array]
    def render
      if Vedeu::Configuration.drb?
        Vedeu.trigger(:_drb_store_output_, content)

        Vedeu::Renderers::HTML.to_file(Vedeu::VirtualBuffer.retrieve)
      end

      Vedeu.renderers.render(content)
    end

    protected

    # @!attribute [r] content
    # @return [Array<Array<Vedeu::Char>>]
    attr_reader :content

  end # Output

end # Vedeu
