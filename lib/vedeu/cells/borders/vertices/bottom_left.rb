# frozen_string_literal: true

module Vedeu

  module Cells

    # Provides the character/escape sequence to draw the bottom left
    # border with a custom value, colour and style.
    #
    # @api private
    #
    class BottomLeft < Vedeu::Cells::Corner

      # @return [String]
      def as_html
        '&#x2514;'
      end

      # @return [Symbol]
      def type
        :bottom_left
      end

      private

      # @return [Hash<Symbol => String>]
      def defaults
        super.merge!(position: Vedeu::Geometries::Position.coerce([yn, x]),
                     value:    Vedeu.esc.bottom_left)
      end

    end # BottomLeft

  end # Cells

end # Vedeu
