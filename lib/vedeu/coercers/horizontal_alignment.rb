module Vedeu

  module Coercers

    # Provides the mechanism to validate a horizontal alignment value.
    #
    # @api private
    #
    class HorizontalAlignment < Vedeu::Coercers::Alignment

      private

      # @return [Array<Symbol>]
      def values
        [
          :centre,
          :center,
          :left,
          :none,
          :right,
        ]
      end

    end # HorizontalAlignment

  end # Coercers

end # Vedeu
