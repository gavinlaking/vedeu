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

        elsif hash?
          klass.new(value.fetch(:y, 1), value.fetch(:x, 1))

        elsif fixnum?
          klass.new(value, 1)

        else
          fail Vedeu::Error::Fatal,
               "Vedeu cannot coerce a '#{value.class.name}' into a " \
               "'#{klass}'."

        end
      end

      private

      # @return [Boolean]
      def fixnum?
        value.is_a?(Fixnum)
      end

      # @return [Boolean]
      def hash?
        value.is_a?(Hash)
      end

      # @return [Class]
      def klass
        Vedeu::Geometries::Position
      end

      # @macro raise_fatal
      # @return [Boolean]
      def tuple?
        return false unless value.is_a?(Array)
        return true  if value.size == 2

        fail Vedeu::Error::Fatal,
             "A '#{klass}' is made up of two elements. (Provided " \
             "#{value.size}.)"
      end

    end # Position

  end # Coercers

end # Vedeu
