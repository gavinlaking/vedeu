module Vedeu

  module Renderers

    # Converts a grid of {Vedeu::Views::Char} objects into a stream of
    # escape sequences and content suitable for a terminal.
    #
    class Terminal

      include Vedeu::Renderers::RendererOptions

      # Returns a new instance of Vedeu::Renderers::Terminal.
      #
      # @param options [Hash]
      # @return [Vedeu::Renderers::Terminal]
      def initialize(options = {})
        @options = options || {}
      end

      # @param output [Vedeu::Models::Page]
      # @return [Array<String>]
      def render(output)
        output = parse(output)

        Vedeu::Terminal.output(output)
      end

      private

      # @param output [Vedeu::Models::Page]
      # @return [Array<Array<Vedeu::Views::Char>>]
      def parse(output)
        Vedeu::Output::Compressor.render(output)
      end

    end # Terminal

  end # Renderers

end # Vedeu
