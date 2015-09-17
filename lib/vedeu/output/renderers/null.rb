module Vedeu

  module Renderers

    # A renderer which returns nothing.
    #
    class Null

      include Vedeu::RendererOptions

      # Returns a new instance of Vedeu::Renderers::Null.
      #
      # @param options [Hash]
      # @return [Vedeu::Renderers::Null]
      def initialize(options = {})
        @options = options || {}
      end

      # @param output [Vedeu::Models::Page]
      # @return [String]
      def render(output)
        output
      end

    end # Null

  end # Renderers

end # Vedeu
