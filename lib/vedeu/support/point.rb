module Vedeu

  class Point

    # @param (see #initialize)
    # @return (see #initialize)
    def self.coerce(value: nil, min: 1, max: nil)
      new(value: value, min: min, max: max).coerce
    end

    # @param (see #initialize)
    # @return (see #initialize)
    def self.valid?(value: nil, min: 1, max: nil)
      new(value: value, min: min, max: max).valid?
    end

    # @param value [Fixnum|NilClass]
    # @param min [Fixnum]
    # @param max [Fixnum]
    # @return [Vedeu::Point]
    def initialize(value: nil, min: 1, max: nil)
      @min   = min
      @max   = max
      @value = value
    end

    # @return [Vedeu::Point]
    def coerce
      fail Vedeu::Error::InvalidSyntax,
           "Expecting 'min' to be less than 'max'." if min > max

      if value < min
        Vedeu::Point.coerce(value: min, min: min, max: max)

      elsif value > max
        Vedeu::Point.coerce(value: max, min: min, max: max)

      else
        self

      end
    end

    # @return [Boolean]
    def valid?
      @value.is_a?(Fixnum) && @value >= min && @value <= max
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

  end # Point

end # Vedeu
