module Vedeu

  module Cells

    # Provides the character/escape sequence to draw one cell of a
    # horizontal border with a custom value, colour and style.
    #
    # @api private
    #
    class Horizontal < Vedeu::Cells::Border

      # @return [String]
      def text
        '-'
      end

      # @return [Symbol]
      def type
        :horizontal
      end

      private

      # @return [Hash<Symbol => String>]
      def defaults
        super.merge!(value: Vedeu::EscapeSequences::Borders.horizontal)
      end

    end # Horizontal

  end # Cells

end # Vedeu
