module Vedeu

  module Coercers

    # Converts a given value into a {Vedeu::Colours::Colour} if
    # possible.
    #
    # @api private
    #
    class Colour

      include Vedeu::Common

      # @param (see #initialize)
      # @return (see #coerce)
      def self.coerce(value)
        new(value).coerce
      end

      # @param value [void]
      # @return [Vedeu::Coercers::Colour]
      def initialize(value)
        @value = value
      end

      # @raise [Vedeu::Error::Fatal] When the value cannot be coerced.
      # @return [void]
      def coerce
        if absent?(value)
          Vedeu::Colours::Colour.new

        elsif background?
          Vedeu::Colours::Colour.new(background: value)

        elsif colour?
          value

        elsif foreground?
          Vedeu::Colours::Colour.new(foreground: value)

        elsif hash?(value)
          attributes = Vedeu::Coercers::ColourAttributes.coerce(value)
          Vedeu::Colours::Colour.new(attributes)

        else
          fail Vedeu::Error::Fatal, 'Vedeu cannot coerce this colour.'.freeze

        end
      end

      protected

      # @!attribute [r] value
      # @return [void]
      attr_reader :value

      private

      # @return [Boolean]
      def background?
        value.is_a?(Vedeu::Colours::Background)
      end

      # @return [Boolean]
      def colour?
        value.is_a?(Vedeu::Colours::Colour)
      end

      # @return [Boolean]
      def foreground?
        value.is_a?(Vedeu::Colours::Foreground)
      end

    end # Colour

  end # Coercers

end # Vedeu
