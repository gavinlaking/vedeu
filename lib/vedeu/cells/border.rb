# frozen_string_literal: true

module Vedeu

  module Cells

    # Provides the character/escape sequence to draw one cell of a
    # border with a custom value, colour and style.
    #
    # @api private
    #
    class Border < Vedeu::Cells::Empty

      extend Forwardable
      include Vedeu::Presentation

      def_delegators :geometry,
                     :x,
                     :xn,
                     :y,
                     :yn

      # @return [Hash<Symbol => void>]
      def attributes
        {
          colour: colour,
          name:   @name,
          style:  style,
        }
      end

      # @return [Boolean]
      def cell?
        false
      end

      # @param value [String|Symbol]
      # @return [Vedeu::Cells::Border]
      def name=(value)
        @name = value

        self
      end

      # @return [Symbol]
      def type
        :border
      end

      # @return [String]
      def value
        return '' unless present?(@value)

        Vedeu.esc.border { @value }
      end

      private

      # @macro defaults_method
      def defaults
        super
      end

    end # Border

  end # Cells

end # Vedeu
