module Vedeu

  module Coercers

    # Provides the mechanism to validate a vertical alignment value.
    #
    # @api private
    #
    class VerticalAlignment < Vedeu::Coercers::Alignment

      private

      # @return [Array<Symbol>]
      def values
        [
          :bottom,
          :middle,
          :none,
          :top,
        ]
      end

    end # VerticalAlignment

  end # Coercers

end # Vedeu
