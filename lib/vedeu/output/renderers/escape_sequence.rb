module Vedeu

  module Renderers

    # A renderer which returns the escape sequence for each character.
    #
    # @api private
    class EscapeSequence

      # Returns a new instance of Vedeu::Renderers::EscapeSequence.
      #
      # @param options [Hash]
      def initialize(options = {})
        @options = options || {}
      end

      # @param output [Array<Array<Vedeu::Char>>]
      # @return [String]
      def render(output)
        @parsed ||= Array(output).flatten.map do |char|
          Esc.escape(char.to_s) + "\n"
        end.join
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

    end # EscapeSequence

  end # Renderers

end # Vedeu
