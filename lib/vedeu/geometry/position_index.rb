module Vedeu

  # Converts a position into an index for the terminal.
  #
  class PositionIndex

    # @!attribute [r] y
    # @return [Fixnum]
    attr_reader :y

    # @!attribute [r] x
    # @return [Fixnum]
    attr_reader :x

    alias_method :first, :y
    alias_method :last, :x

    # @param (see #initialize)
    def self.[](y, x)
      new(y, x).[]
    end

    # Returns a new instance of Vedeu::PositionIndex.
    #
    # @param y [Fixnum]
    # @param x [Fixnum]
    # @return [Vedeu::PositionIndex]
    def initialize(y, x)
      @y = ((y - 1) <= 1) ? 0 : (y - 1)
      @x = ((x - 1) <= 1) ? 0 : (x - 1)
    end

    # @return [Array]
    def []
      [y, x]
    end

    # @param other [Vedeu::PositionIndex]
    # @return [Boolean]
    def eql?(other)
      self.class == other.class && (x == other.x && y == other.y)
    end
    alias_method :==, :eql?

    # @return [Vedeu::Position]
    def to_position
      Vedeu::Position.new(y, x)
    end

  end # PositionIndex

end # Vedeu
