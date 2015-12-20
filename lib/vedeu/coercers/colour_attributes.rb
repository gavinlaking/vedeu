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

      # @return [Hash]
      def coerce
        fail Vedeu::Error::InvalidSyntax unless hash?(value)

        if colour?
          Vedeu::Coercers::ColourAttributes.coerce(value[:colour])

        else
          background.merge(foreground)

        end
      end

      protected

      # @!attribute [r] value
      # @return [Hash]
      attr_reader :value

      private

      # @return [Hash]
      def background
        if background?
          {
            background: value[:background]
          }

        else
          {}

        end
      end

      # @return [Boolean]
      def background?
        value.key?(:background) && valid?(value[:background])
      end

      # @return [Hash]
      def colour
        value[:colour]
      end

      # @return [Boolean]
      def colour?
        value.key?(:colour) && hash?(value[:colour])
      end

      # @return [Hash]
      def foreground
        if foreground?
          {
            foreground: value[:foreground]
          }

        else
          {}

        end
      end

      # @return [Boolean]
      def foreground?
        value.key?(:foreground) && valid?(value[:foreground])
      end

      # @return [Boolean]
      def valid?(colour)
        Vedeu::Colours::Validator.valid?(colour)
      end

    end # ColourAttributes

  end # Coercers

end # Vedeu
