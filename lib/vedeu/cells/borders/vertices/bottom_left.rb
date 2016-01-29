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

      # @macro defaults_method
      def defaults
        super.merge!(position: Vedeu::Geometries::Position.new(yn, x),
                     value:    Vedeu.esc.bottom_left)
      end

    end # BottomLeft

  end # Cells

end # Vedeu
