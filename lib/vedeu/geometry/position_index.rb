module Vedeu

  # Converts a position into an index for the terminal. An index is the position
  # minus 1.
  #
  class PositionIndex

    # Convenience constructor for Vedeu::Position.
    #
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

    # Returns a tuple containing the y and x coordinates.
    #
    # @return [Array<Fixnum>]
    def []
      [y, x]
    end

    # An object is equal when its values are the same.
    #
    # @param other [Vedeu::PositionIndex]
    # @return [Boolean]
    def eql?(other)
      self.class == other.class && (x == other.x && y == other.y)
    end
    alias_method :==, :eql?

    # Converts the index values into a Vedeu::Position.
    #
    # @return [Vedeu::Position]
    def to_position
      Vedeu::Position[y, x]
    end

    # Returns the x index.
    # If the position for x is less than 1, then the index is 0.
    #
    # @return [Fixnum]
    def x
      @_x ||= ((@x - 1) <= 1) ? 0 : (@x - 1)
    end
    alias_method :last, :x

    # Returns the y index.
    # If the position for y is less than 1, then the index is 0.
    #
    # @return [Fixnum]
    def y
      @_y ||= ((@y - 1) <= 1) ? 0 : (@y - 1)
    end
    alias_method :first, :y

  end # PositionIndex

end # Vedeu
