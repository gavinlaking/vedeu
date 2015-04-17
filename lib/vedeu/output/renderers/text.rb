module Vedeu

  # Converts a grid of {Vedeu::Char} objects into a stream of escape sequences
  # and content.
  #
  class Renderers::Text

    # @param output [Array<Array<Vedeu::Char>>]
    # @return [String]
    def self.render(*output)
      new(*output).render
    end

    # Returns a new instance of Vedeu::Renderers::Text.
    #
    # @param output [Array<Array<Vedeu::Char>>]
    # @return [Vedeu::Renderers::Text]
    def initialize(*output)
      @output  = output
    end

    # @return [String]
    def render
      parsed
    end

    private

    # @!attribute [r] output
    # @return [Array<Array<Vedeu::Char>>]
    attr_reader :output

    # @return [String]
    def parsed
      Vedeu::Compressor.new(output).render
    end

  end # Renderers::Text

end # Vedeu
