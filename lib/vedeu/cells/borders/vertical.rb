module Vedeu

  module Cells

    # Provides the character/escape sequence to draw one cell of a
    # vertical border with a custom value, colour and style.
    #
    # @api private
    #
    class Vertical < Vedeu::Cells::Border

      # @return [String]
      def text
        '|'
      end

      # @return [Symbol]
      def type
        :vertical
      end

      private

      # @return [Hash<Symbol => String>]
      def defaults
        super.merge!(value: Vedeu::EscapeSequences::Borders.vertical)
      end

    end # Vertical

  end # Cells

end # Vedeu
