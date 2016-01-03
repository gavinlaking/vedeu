# frozen_string_literal: true

module Vedeu

  module Cells

    # Provides the character/escape sequence to draw one cell of a
    # vertical border with a custom value, colour and style.
    #
    # @api private
    #
    class Vertical < Vedeu::Cells::Border

      # @return [String]
      def as_html
        '&#x2502;'
      end

      # @return [String]
      def text
        '|'
      end

      # @return [Symbol]
      def type
        :vertical
      end

      private

      # @return [Hash<Symbol => String>]
      def defaults
        super.merge!(value: Vedeu.esc.vertical)
      end

    end # Vertical

  end # Cells

end # Vedeu
