# frozen_string_literal: true

module Vedeu

  module Cells

    # Provides the character/escape sequence to draw the top right
    # border with a custom value, colour and style.
    #
    # @api private
    #
    class TopRight < Vedeu::Cells::Corner

      # @return [Symbol]
      def type
        :top_right
      end

      private

      # @return [Hash<Symbol => String>]
      def defaults
        super.merge!(position: Vedeu::Geometries::Position.coerce([y, xn]),
                     value:    Vedeu::EscapeSequences::Borders.top_right)
      end

    end # TopRight

  end # Cells

end # Vedeu
