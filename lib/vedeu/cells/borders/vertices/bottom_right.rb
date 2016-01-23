# frozen_string_literal: true

module Vedeu

  module Cells

    # Provides the character/escape sequence to draw the bottom right
    # border with a custom value, colour and style.
    #
    # @api private
    #
    class BottomRight < Vedeu::Cells::Corner

      # @return [String]
      def as_html
        '&#x2518;'
      end

      # @return [Symbol]
      def type
        :bottom_right
      end

      private

      # @return [Hash<Symbol => String>]
      def defaults
        super.merge!(position: Vedeu::Geometries::Position.new(yn, xn),
                     value:    Vedeu.esc.bottom_right)
      end

    end # BottomRight

  end # Cells

end # Vedeu
