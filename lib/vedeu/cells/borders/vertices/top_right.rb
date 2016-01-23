# frozen_string_literal: true

module Vedeu

  module Cells

    # Provides the character/escape sequence to draw the top right
    # border with a custom value, colour and style.
    #
    # @api private
    #
    class TopRight < Vedeu::Cells::Corner

      # @return [String]
      def as_html
        '&#x2510;'
      end

      # @return [Symbol]
      def type
        :top_right
      end

      private

      # @return [Hash<Symbol => String>]
      def defaults
        super.merge!(position: Vedeu::Geometries::Position.new(y, xn),
                     value:    Vedeu.esc.top_right)
      end

    end # TopRight

  end # Cells

end # Vedeu
