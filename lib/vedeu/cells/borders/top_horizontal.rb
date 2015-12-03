module Vedeu

  module Cells

    # Provides the character/escape sequence to draw one cell of the
    # top horizontal border with a custom value, colour and style.
    #
    # @api private
    #
    class TopHorizontal < Vedeu::Cells::Horizontal

      # @return [Symbol]
      def type
        :top_horizontal
      end

      private

      # @return [Hash<Symbol => String>]
      def defaults
        super.merge!(value: Vedeu::EscapeSequences::Borders.horizontal)
      end

    end # TopHorizontal

  end # Cells

end # Vedeu
