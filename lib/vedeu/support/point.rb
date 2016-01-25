module Vedeu

  # A `Vedeu::Point` represents part of a coordinate within the 2D
  # space of a terminal. This class is specifically used to coerce
  # a coordinate to be within boundaries. The `min` and `max`
  # arguments are used to define this boundary.
  #
  # @api private
  #
  class Point

    # @param (see #initialize)
    # @macro raise_invalid_syntax
    # @return (see #initialize)
    def self.coerce(value: nil, min: 1, max: Float::INFINITY)
      new(value: value, min: min, max: max).coerce
    end

    # @param (see #initialize)
    # @return (see #initialize)
    def self.valid?(value: nil, min: 1, max: Float::INFINITY)
      new(value: value, min: min, max: max).valid?
    end

    # @param value [Fixnum|NilClass]
    # @param min [Fixnum]
    # @param max [Fixnum|Float::INFINITY]
    # @return [Vedeu::Point]
    def initialize(value: nil, min: 1, max: Float::INFINITY)
      @min   = min
      @max   = max
      @value = value
    end

    # @macro raise_invalid_syntax
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

    # @macro raise_invalid_syntax
    # @return [Fixnum]
    def min
      return @min if @min.is_a?(Fixnum)

      fail Vedeu::Error::InvalidSyntax,
           "Expecting 'min' to be a Fixnum."
    end

    # @macro raise_invalid_syntax
    # @return [Fixnum]
    def max
      return @max if @max.is_a?(Fixnum) || @max == Float::INFINITY

      fail Vedeu::Error::InvalidSyntax,
           "Expecting 'max' to be a Fixnum or Float::INFINITY."
    end

  end # Point

end # Vedeu
