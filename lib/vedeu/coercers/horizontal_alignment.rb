module Vedeu

  module Coercers

    # Provides the mechanism to validate a horizontal alignment value.
    #
    # @api private
    #
    class HorizontalAlignment < Vedeu::Coercers::Alignment

      # @raise [Vedeu::Error::InvalidSyntax] When the value is not one
      #   of :center, :centre, :left, :none, or :right.
      # @return [Symbol]
      def align
        return value if valid?

        fail Vedeu::Error::InvalidSyntax,
             'No horizontal alignment value given. Valid values are :center, ' \
             ':centre, :left, :none, :right.'.freeze
      end

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
