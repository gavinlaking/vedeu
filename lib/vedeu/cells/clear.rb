# frozen_string_literal: true

module Vedeu

  module Cells

    # Provides the character/escape sequence to draw one cell of a
    # with a custom value, colour and style.
    #
    # The Vedeu::Cells::Clear object represents a cleared cell using
    # the space character.
    #
    # @api private
    #
    class Clear < Vedeu::Cells::Empty

      # @return [Boolean]
      def cell?
        false
      end

      # @return [Symbol]
      def type
        :clear
      end

      # @return [String]
      def value
        ' '
      end
      alias text value

    end # Clear

  end # Cells

end # Vedeu
