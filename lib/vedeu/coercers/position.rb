# frozen_string_literal: true

module Vedeu

  module Coercers

    # Provides the mechanism to convert a value into a
    # {Vedeu::Geometries::Position}.
    #
    # @api private
    #
    class Position < Vedeu::Coercers::Coercer

      # @macro raise_fatal
      # @return [NilClass|Vedeu::Geometries::Position]
      def coerce
        if value.nil? || coerced?
          value

        elsif tuple?
          klass.new(*value)

        elsif hash?(value)
          klass.new(value.fetch(:y, 1), value.fetch(:x, 1))

        elsif numeric?(value)
          klass.new(value, 1)

        else
          incoercible!

        end
      end

      private

      # @return [Class]
      def klass
        Vedeu::Geometries::Position
      end

      # @macro raise_fatal
      # @return [Boolean]
      def tuple?
        return false unless array?(value)
        return true  if value.size == 2

        raise Vedeu::Error::Fatal,
              "A '#{klass}' is made up of two elements. (Provided " \
              "#{value.size}.)"
      end

    end # Position

  end # Coercers

end # Vedeu
