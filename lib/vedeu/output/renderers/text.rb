module Vedeu

  module Renderers

    # Converts a grid of {Vedeu::Char} objects into a stream of escape sequences
    # and content.
    #
    # @api private
    class Text

      # Returns a new instance of Vedeu::Renderers::Text.
      #
      # @param options [Hash]
      # @return [Vedeu::Renderers::Text]
      def initialize(options = {})
        @options = options || {}
      end

      # @param output [Array<Array<Vedeu::Char>>]
      # @return [String]
      def render(output)
        Vedeu::Compressor.render(output)
      end

      private

      # Combines the options provided at instantiation with the default values.
      #
      # @return [Hash<Symbol => void>]
      def options
        defaults.merge!(@options)
      end

      # The default values for a new instance of this class.
      #
      # @return [Hash<Symbol => void>]
      def defaults
        {}
      end

    end # Text

  end # Renderers

end # Vedeu
