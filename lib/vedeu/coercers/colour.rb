module Vedeu

  module Coercers

    class Colour

      include Vedeu::Common

      # @param value [void]
      def self.coerce(value)
        new(value).coerce
      end

      # @param value [void]
      # @return [Vedeu::Coercers::Colour]
      def initialize(value)
        @value = value
      end

      # @return [void]
      def coerce
        fail Vedeu::Error::InvalidSyntax unless present?(value)

        if background?
          :background

        elsif colour?
          :colour

        elsif foreground?
          :foreground

        elsif hash?


        else
          :not_yet_supported

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

      def hash?
        value.is_a?(Hash)
      end

    end # Colour

  end # Coercers

end # Vedeu
