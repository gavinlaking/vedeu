module Vedeu

  # Converts a grid of {Vedeu::Char} objects into a stream of escape sequences
  # and content suitable for a terminal.
  #
  class Renderers::Terminal

    # @param output [Array<Array<Vedeu::Char>>]
    # @return [String]
    def self.render(*output)
      new(*output).render
    end

    # Returns a new instance of Vedeu::Renderers::Terminal.
    #
    # @param output [Array<Array<Vedeu::Char>>]
    # @return [Vedeu::Renderers::Terminal]
    def initialize(*output)
      @output = output
    end

    # @return [Array<String>]
    def render
      Vedeu::Terminal.output(parsed)
    end

    private

    # @!attribute [r] output
    # @return [Array<Array<Vedeu::Char>>]
    attr_reader :output

    # @return [String]
    def parsed
      Vedeu::Compressor.new(output).render
    end

  end # Renderers::Terminal

end # Vedeu
