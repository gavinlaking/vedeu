# frozen_string_literal: true

module Vedeu

  module Cells

    # Provides the character/escape sequence to draw one cell of the
    # left vertical border with a custom value, colour and style.
    #
    # @api private
    #
    class LeftVertical < Vedeu::Cells::Vertical

      # @return [Symbol]
      def type
        :left_vertical
      end

      private

      # @return [Hash<Symbol => String>]
      def defaults
        super.merge!(value: Vedeu::EscapeSequences::Borders.vertical)
      end

    end # LeftVertical

  end # Cells

end # Vedeu
