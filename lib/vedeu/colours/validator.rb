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

      # @return [Boolean]
      def valid?
        rgb?
      end

      protected

      # @!attribute [r] value
      # @return [String]
      attr_reader :value

      private

      # @return [Boolean]
      def rgb?
        return true if value =~ /^#([A-Fa-f0-9]{6})$/.freeze

        false
      end

    end # Validator

  end # Colours

end # Vedeu
