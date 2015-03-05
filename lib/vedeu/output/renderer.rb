module Vedeu

  # Converts a grid of {Vedeu::Char} objects into a stream of escape sequences
  # and content suitable for a terminal.
  #
  class Renderer

    # @param output [Array<Array<Vedeu::Char>>]
    # @return [String]
    def self.render(*output)
      new(*output).render
    end

    # @param output [Array<Array<Vedeu::Char>>]
    # @return [Vedeu::Renderer]
    def initialize(*output)
      @output = output
    end

    # @return [String]
    def render
      Array(output).flatten.map(&:to_s).join
    end

    private

    attr_reader :output

  end # Renderer

end # Vedeu
