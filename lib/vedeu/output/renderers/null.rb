module Vedeu

  module Renderers

    # A renderer which returns nothing.
    #
    # @api private
    class Null

      # Returns a new instance of Vedeu::Renderers::Null.
      #
      # @param options [Hash]
      # @return [Vedeu::Renderers::Null]
      def initialize(options = {})
        @options = options
      end

      # @param output [Array<Array<Vedeu::Char>>]
      # @return [String]
      def render(output)
      end

      private

      # @return [Hash<Symbol => void>]
      def options
        defaults.merge!(@options)
      end

      # @return [Hash<Symbol => void>]
      def defaults
        {}
      end

    end # Null

  end # Renderers

end # Vedeu
