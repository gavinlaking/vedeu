module Vedeu

  module Cells

    # Provides the character/escape sequence to draw one cell of the
    # bottom horizontal border with a custom value, colour and style.
    #
    # @api private
    #
    class BottomHorizontal < Vedeu::Cells::Horizontal

      # @return [Symbol]
      def type
        :bottom_horizontal
      end

      private

      # @return [Hash<Symbol => String>]
      def defaults
        super.merge!(value: Vedeu::EscapeSequences::Borders.horizontal)
      end

    end # BottomHorizontal

  end # Cells

end # Vedeu
