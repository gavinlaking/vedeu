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

      class ColourAttributes

        include Vedeu::Common

        # @param value [Hash]
        def self.coerce(value)
          new(value).coerce
        end

        def initialize(value)
          @value = value
        end

        # @return [Hash]
        def coerce
          fail Vedeu::Error::InvalidSyntax unless hash?(value)


        end

        protected

        # @!attribute [r] value
        # @return [Hash]
        attr_reader :value

        private

        def background
          valid.key?(:background)
        end

        def colour
          valid.key?(:colour)
        end

        def foreground
          valid.key?(:foreground)
        end

        def valid
          value.keep_if { |k, v| valid_keys.include?(k) && present?(v) }
        end

        def valid_attributes
          [:background, :colour, :foreground]
        end

        def valid_colour_attributes
          [:background, :foreground]
        end

      end # ColourAttributes

    end # Colour

  end # Coercers

end # Vedeu
