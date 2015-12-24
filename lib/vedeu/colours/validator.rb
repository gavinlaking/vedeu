module Vedeu

  module Colours

    # Validates the value as a valid colour string in HTML/CSS format,
    # e.g. '#123456'.
    #
    # @api private
    #
    class Validator

      include Vedeu::Common

      # @param value [String]
      # @return [Boolean]
      def self.valid?(value)
        new(value).valid?
      end

      # @param value [String]
      # @return [Vedeu::Colours::Validator]
      def initialize(value)
        @value = value
      end

      # Returns a boolean indicating whether the value is within the
      # range of valid terminal numbered colours.
      #
      # @return [Boolean]
      def within_range?
        numeric?(value) && value >= 0 && value <= 255
      end

      # Returns a boolean indicating whether the colour provided is a
      # valid named colour.
      #
      # @return [Boolean]
      def named?
        Vedeu::EscapeSequences::Esc.valid_name?(value)
      end

      # Returns a boolean indicated whether the colour is a valid
      # HTML/CSS colour.
      #
      # @return [Boolean]
      def rgb?
        return true if value =~ /^#([A-Fa-f0-9]{6})$/.freeze

        false
      end

      # @return [Boolean]
      def valid?
        background? || colour? || foreground? || rgb? || named? || within_range?
      end

      protected

      # @!attribute [r] value
      # @return [String]
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

    end # Validator

  end # Colours

end # Vedeu
