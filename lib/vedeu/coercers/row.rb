# frozen_string_literal: true

module Vedeu

  module Coercers

    # Provides the mechanism to convert a value into a
    # {Vedeu::Models::Row}.
    #
    # @api private
    #
    class Row < Vedeu::Coercers::Coercer

      # @return [void]
      def coerce
        if coerced?
          value

        else


        end
      end

      private

      # @return [Class]
      def klass
        Vedeu::Models::Row
      end

    end # Row

  end # Coercers

end # Vedeu
