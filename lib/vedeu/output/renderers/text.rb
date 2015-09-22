module Vedeu

  module Renderers

    # Converts a grid of {Vedeu::Views::Char} objects into a stream of
    # escape sequences and content.
    #
    class Text

      include Vedeu::Renderers::RendererOptions

      # Returns a new instance of Vedeu::Renderers::Text.
      #
      # @param options [Hash]
      # @return [Vedeu::Renderers::Text]
      def initialize(options = {})
        @options = options || {}
      end

      # Render a cleared output.
      #
      # @return [String]
      def clear
        ''
      end

      # @param output [Vedeu::Models::Page]
      # @return [String]
      def render(output)
        Vedeu::Output::Compressor.render(output)
      end

    end # Text

  end # Renderers

end # Vedeu
