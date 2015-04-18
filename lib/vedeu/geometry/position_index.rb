module Vedeu

  # Converts a position into an index for the terminal.
  #
  class PositionIndex

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
      @y = y
      @x = x
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

    # @return [Fixnum]
    def x
      @_x ||= ((@x - 1) <= 1) ? 0 : (@x - 1)
    end
    alias_method :last, :x

    # @return [Fixnum]
    def y
      @_y ||= ((@y - 1) <= 1) ? 0 : (@y - 1)
    end
    alias_method :first, :y

  end # PositionIndex

end # Vedeu
