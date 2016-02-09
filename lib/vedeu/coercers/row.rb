# frozen_string_literal: true

module Vedeu

  module Coercers

    # Provides the mechanism to convert a value into a
    # {Vedeu::Models::Row}.
    #
    # @api private
    #
    class Row < Vedeu::Coercers::Coercer

      # @return [Vedeu::Models::Row]
      def coerce
        if coerced?
          value

        elsif array?(value)
          klass.new(value.compact)

        elsif value.nil?
          klass.new

        else
          klass.new([value])

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
