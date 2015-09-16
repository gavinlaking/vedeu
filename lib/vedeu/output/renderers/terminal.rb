module Vedeu

  module Renderers

    # Converts a grid of {Vedeu::Views::Char} objects into a stream of
    # escape sequences and content suitable for a terminal.
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

      # @param output [Array<Array<Vedeu::Views::Char>>]
      # @return [Array<String>]
      def render(output)
        Vedeu::Terminal.output(parsed(output))
      end

      private

      # @param output [Array<Array<Vedeu::Views::Char>>]
      # @return [Array<Array<Vedeu::Views::Char>>]
      def parsed(output)
        store!(output)

        Vedeu.timer('Compression') do
          Vedeu::Output::Compressor.render(output)
        end
      end

      # @param output [Array<Array<Vedeu::Views::Char>>]
      # @return [Array<Vedeu::Views::Char>]
      def store!(output)
        Vedeu::Terminal::Content.stores(output)
      end

    end # Terminal

  end # Renderers

end # Vedeu
