# frozen_string_literal: true

module Vedeu

  module Cells

    # Provides the character/escape sequence to draw one cell of the
    # right vertical border with a custom value, colour and style.
    #
    # @api private
    #
    class RightVertical < Vedeu::Cells::Vertical

      # @return [Symbol]
      def type
        :right_vertical
      end

      private

      # @macro defaults_method
      def defaults
        super.merge!(value: Vedeu.esc.vertical)
      end

    end # RightVertical

  end # Cells

end # Vedeu
