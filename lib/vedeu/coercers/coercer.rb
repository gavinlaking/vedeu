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
      def self.coerce(value)
        new(value).coerce
      end

      # Returns a new instance of the Vedeu::Coercers::Coercer
      # subclass.
      #
      # @param value [void]
      # @return [Vedeu::Coercers::Coercer]
      def initialize(value)
        @value = value
      end

      # @macro raise_not_implemented
      # @return [void]
      def coerce
        raise Vedeu::Error::NotImplemented, 'Subclasses implement this.'
      end

      protected

      # @!attribute [r] value
      # @return [void]
      attr_reader :value

      private

      # @return [Boolean]
      def coerced?
        value.is_a?(klass)
      end

      # @macro raise_fatal
      # @return [void]
      def incoercible!
        raise Vedeu::Error::Fatal,
              "Vedeu cannot coerce a '#{value.class.name}' into a '#{klass}'."
      end

      # @macro raise_not_implemented
      # @return [Class]
      def klass
        raise Vedeu::Error::NotImplemented, 'Subclasses implement this.'
      end

    end # Coercer

  end # Coercers

end # Vedeu
