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

      # Render the output with the escape sequences escaped.
      #
      # @param output [Array<Array<Vedeu::Char>>]
      # @return [String]
      def render(output)
        @parsed ||= Array(output).flatten.map do |char|
          Esc.escape(char.to_s) + "\n"
        end.join
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

    end # EscapeSequence

  end # Renderers

end # Vedeu
