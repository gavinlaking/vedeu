# frozen_string_literal: true

module Vedeu

  module Coercers

    # Coerces a colour options hash into: an empty hash, or a hash
    # containing either or both background and foreground keys.
    #
    # @api private
    #
    class ColourAttributes

      include Vedeu::Common

      # @param value [Hash]
      # @return [Hash]
      def self.coerce(value)
        new(value).coerce
      end

      # @param value [Hash]
      # @return [Hash]
      def initialize(value)
        @value = value
      end

      # @macro raise_invalid_syntax
      # @return [Hash]
      def coerce
        raise Vedeu::Error::InvalidSyntax unless hash?(value)

        if colour? && hash?(colour)
          Vedeu::Coercers::ColourAttributes.coerce(colour)

        elsif colour? && coerced?(colour)
          colour.attributes

        else
          coerced_background.merge(coerced_foreground)

        end
      end

      protected

      # @!attribute [r] value
      # @return [Hash]
      attr_reader :value

      private

      # @param colour [void]
      # @return [Boolean]
      def coerced?(colour)
        colour.is_a?(klass)
      end

      # @return [Hash]
      def coerced_background
        return {} unless background?

        {
          background: background,
        }
      end

      # @return [NilClass|String]
      def background
        value[:background]
      end

      # @return [Boolean]
      def background?
        valid?(background)
      end

      # @return [Hash]
      def colour
        value[:colour]
      end

      # @return [Boolean]
      def colour?
        value.key?(:colour)
      end

      # @return [Hash]
      def coerced_foreground
        return {} unless foreground?

        {
          foreground: foreground,
        }
      end

      # @return [NilClass|String]
      def foreground
        value[:foreground]
      end

      # @return [Boolean]
      def foreground?
        valid?(foreground)
      end

      # @return [Class]
      def klass
        Vedeu::Colours::Colour
      end

      # @param colour [void]
      # @return [Boolean]
      def valid?(colour)
        Vedeu::Colours::Validator.valid?(colour)
      end

    end # ColourAttributes

  end # Coercers

end # Vedeu
