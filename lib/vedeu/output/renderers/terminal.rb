module Vedeu

  module Renderers

    # Converts a grid of {Vedeu::Char} objects into a stream of escape sequences
    # and content suitable for a terminal.
    #
    class Terminal

      include Vedeu::RendererOptions

      # Returns a new instance of Vedeu::Renderers::Terminal.
      #
      # @param options [Hash]
      # @return [Vedeu::Renderers::Terminal]
      def initialize(options = {})
        @options = options || {}
      end

      # @param output [Array<Array<Vedeu::Char>>]
      # @return [Array<String>]
      def render(output)
        Vedeu::Terminal.output(parsed(output))
      end

      private

      # @param output [Array<Array<Vedeu::Char>>]
      # @return [Array<Array<Vedeu::Char>>]
      def parsed(output)
        Vedeu.timer('Compression') do
          Vedeu::Compressor.render(output)
        end
      end

    end # Terminal

  end # Renderers

end # Vedeu
