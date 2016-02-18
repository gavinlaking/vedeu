# frozen_string_literal: true

module Vedeu

  module Coercers

    # Provides the mechanism to convert a value into a
    # {Vedeu::Views::Lines}.
    #
    # @api private
    #
    class Lines < Vedeu::Coercers::Coercer

      # @macro raise_fatal
      # @return [Vedeu::Views::Lines]
      def coerce
        if coerced?
          value

        else
          incoercible!

        end
      end

      private

      # @return [Class]
      def klass
        Vedeu::Views::Lines
      end

    end # Lines

  end # Coercers

end # Vedeu
