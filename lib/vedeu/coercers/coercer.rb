# frozen_string_literal: true

module Vedeu

  module Coercers

    # Provides the mechanism to convert a value into another value.
    #
    # @api private
    #
    class Coercer

      include Vedeu::Common

      # @param (see #initialize)
      # @return (see #coerce)
      def self.coerce(value, attributes = {})
        new(value, attributes).coerce
      end

      # Returns a new instance of the Vedeu::Coercers::Coercer
      # subclass.
      #
      # @param value [void]
      # @param attributes [Hash<Symbol => void>]
      # @return [Vedeu::Coercers::Coercer]
      def initialize(value, attributes = {})
        @value      = value
        @attributes = attributes
      end

      # @macro raise_not_implemented
      def coerce
        raise Vedeu::Error::NotImplemented
      end

      protected

      # @!attribute [r] attributes
      # @return [void]
      attr_reader :attributes

      # @!attribute [r] value
      # @return [void]
      attr_reader :value

      private

      # @macro raise_not_implemented
      def child_klass
        raise Vedeu::Error::NotImplemented
      end

      # @return [Boolean]
      def coerced?
        value.is_a?(klass)
      end

      # @macro raise_fatal
      def incoercible!
        raise Vedeu::Error::Fatal,
              "Vedeu cannot coerce a '#{value.class.name}' into a '#{klass}'."
      end

      # @macro raise_not_implemented
      def klass
        raise Vedeu::Error::NotImplemented
      end

    end # Coercer

  end # Coercers

end # Vedeu
