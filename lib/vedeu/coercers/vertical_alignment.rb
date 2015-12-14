module Vedeu

  module Coercers

    # Provides the mechanism to validate a vertical alignment value.
    #
    # @api private
    #
    class VerticalAlignment < Vedeu::Coercers::Alignment

      # @raise [Vedeu::Error::InvalidSyntax] When the value is not one
      #   of :bottom, :middle, :none or :top.
      # @return [Symbol]
      def align
        return value if valid?

        fail Vedeu::Error::InvalidSyntax,
             'No vertical alignment value given. Valid values are :bottom, ' \
             ':middle, :none, :top.'.freeze
      end

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
