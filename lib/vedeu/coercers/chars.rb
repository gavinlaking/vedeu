# frozen_string_literal: true

module Vedeu

  module Coercers

    # Provides the mechanism to convert a value into a
    # {Vedeu::Views::Chars}.
    #
    # @api private
    #
    class Chars < Vedeu::Coercers::Coercer

      # @return [void]
      def coerce
      end

      private

      # @return [Class]
      def klass
        Vedeu::Views::Chars
      end

    end # Chars

  end # Coercers

end # Vedeu
