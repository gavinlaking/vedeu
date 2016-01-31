# frozen_string_literal: true

module Vedeu

  module Cells

    # Provides the character/escape sequence to draw the top left
    # border with a custom value, colour and style.
    #
    # @api private
    #
    class TopLeft < Vedeu::Cells::Corner

      # @return [String]
      def as_html
        '&#x250C;'
      end

      # @return [Symbol]
      def type
        :top_left
      end

      private

      # @macro defaults_method
      def defaults
        super.merge!(position: Vedeu::Geometries::Position.new(y, x),
                     value:    Vedeu.esc.top_left)
      end

    end # TopLeft

  end # Cells

end # Vedeu
