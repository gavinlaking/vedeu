module Vedeu

  module Cells

    # Provides the character/escape sequence to draw one cell of a
    # border with a custom value, colour and style.
    #
    # @api private
    #
    class Border < Vedeu::Cells::Empty

      include Vedeu::Common

      # @return [String]
      def value
        return '' unless present?(@value)

        Vedeu::EscapeSequences::Esc.border { @value }
      end

      private

      # @return [Hash<Symbol => Hash<void>>]
      def defaults
        super.merge!(border: {})
      end

    end # Border

  end # Cells

end # Vedeu
