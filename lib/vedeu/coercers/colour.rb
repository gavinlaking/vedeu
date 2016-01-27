# frozen_string_literal: true

module Vedeu

  module Coercers

    # Converts a given value into a {Vedeu::Colours::Colour} if
    # possible.
    #
    # @api private
    #
    class Colour < Vedeu::Coercers::Coercer

      # @macro raise_fatal
      # @return [Vedeu::Colours::Colour]
      def coerce
        if coerced?
          value

        elsif absent?(value)
          klass.new

        elsif background?
          klass.new(background: value)

        elsif foreground?
          klass.new(foreground: value)

        elsif hash?(value)
          klass.new(colour_attributes)

        else
          incoercible!

        end
      end

      private

      # @return [Hash]
      def colour_attributes
        Vedeu::Coercers::ColourAttributes.coerce(value)
      end

      # @return [Boolean]
      def background?
        value.is_a?(Vedeu::Colours::Background)
      end

      # @return [Boolean]
      def foreground?
        value.is_a?(Vedeu::Colours::Foreground)
      end

      # @return [Class]
      def klass
        Vedeu::Colours::Colour
      end

    end # Colour

  end # Coercers

end # Vedeu
