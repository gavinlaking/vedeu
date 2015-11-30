module Vedeu

  module Cells

    class Border < Empty

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
