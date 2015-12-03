module Vedeu

  module Cells

    # Provides the character/escape sequence to draw the bottom right
    # border with a custom value, colour and style.
    #
    # @api private
    #
    class BottomRight < Vedeu::Cells::Corner

      # @return [Symbol]
      def type
        :bottom_right
      end

      private

      # @return [Hash<Symbol => String>]
      def defaults
        super.merge!(position: Vedeu::Geometries::Position.coerce([yn, xn]),
                     value:    Vedeu::EscapeSequences::Borders.bottom_right)
      end

    end # BottomRight

  end # Cells

end # Vedeu
