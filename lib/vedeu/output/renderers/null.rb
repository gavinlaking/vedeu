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
        @options = options || {}
      end

      # @param output [Array<Array<Vedeu::Char>>]
      # @return [String]
      def render(output)
        output
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

    end # Null

  end # Renderers

end # Vedeu
