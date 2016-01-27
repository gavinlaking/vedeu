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
      # @return [void]
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
          attributes = Vedeu::Coercers::ColourAttributes.coerce(value)
          klass.new(attributes)

        else
          fail Vedeu::Error::Fatal, 'Vedeu cannot coerce this colour.'

        end
      end

      private

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
