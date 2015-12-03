module Vedeu

  module Cells

    # Provides the character/escape sequence to draw the top left
    # border with a custom value, colour and style.
    #
    # @api private
    #
    class TopLeft < Vedeu::Cells::Corner

      # @return [Symbol]
      def type
        :top_left
      end

      private

      # @return [Hash<Symbol => String>]
      def defaults
        super.merge!(position: Vedeu::Geometries::Position.coerce([y, x]),
                     value:    Vedeu::EscapeSequences::Borders.top_left)
      end

    end # TopLeft

  end # Cells

end # Vedeu
