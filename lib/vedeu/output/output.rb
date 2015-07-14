module Vedeu

  # Sends the output to the renderers.
  #
  # @api private
  class Output

    # Writes output to the defined renderers.
    #
    # @return [Array|String]
    # @see #initialize
    def self.render(output)
      new(output).render
    end

    # Return a new instance of Vedeu::Output.
    #
    # @param output [Array<Array<Vedeu::Char>>]
    # @return [Output]
    def initialize(output)
      @output = output
    end

    # Send the view to the renderers.
    #
    # @return [Array]
    def render
      if Vedeu::Configuration.drb?
        Vedeu.trigger(:_drb_store_output_, output)

        # Vedeu::Renderers::HTML.to_file(Vedeu::VirtualBuffer.retrieve)
      end

      Vedeu.renderers.render(output)
    end

    protected

    # @!attribute [r] output
    # @return [Array<Array<Vedeu::Char>>]
    attr_reader :output

  end # Output

end # Vedeu
