module Vedeu

  module Coercers

    class Coordinate

      # @param (see #initialize)
      # @return (see #initialize)
      def self.coerce(value: nil, min: nil, max: nil)
        new(value: value, min: min, max: max).coerce
      end

      # @param value [Fixnum|NilClass]
      # @param min [Fixnum]
      # @param max [Fixnum]
      # @return [Vedeu::Coordinate]
      def initialize(value: nil, min: nil, max: nil)
        @min   = min
        @max   = max
        @value = value
      end

      # @return [Vedeu::Coordinate]
      def coerce
        fail Vedeu::Error::InvalidSyntax,
             "Expecting 'min' to be less than 'max'." if min > max

        if value < min
          Vedeu::Coercers::Coordinate.coerce(value: min, min: min, max: max)

        elsif value > max
          Vedeu::Coercers::Coordinate.coerce(value: max, min: min, max: max)

        else
          self

        end
      end

      # @return [Fixnum]
      def value
        @value ||= min
      end

      private

      # @return [Fixnum]
      def min
        return @min if @min.is_a?(Fixnum)

        fail Vedeu::Error::InvalidSyntax, "Expecting 'min' to be a Fixnum."
      end

      # @return [Fixnum]
      def max
        return @max if @max.is_a?(Fixnum)

        fail Vedeu::Error::InvalidSyntax, "Expecting 'max' to be a Fixnum."
      end

    end # Coordinate

  end # Coercers

end # Vedeu
