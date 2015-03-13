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

    # @param y [Fixnum]
    # @param x [Fixnum]
    # @return [Vedeu::PositionIndex]
    def initialize(y, x)
      @y = ((y - 1) <= 1) ? 1 : (y - 1)
      @x = ((x - 1) <= 1) ? 1 : (x - 1)
    end

    # @return [Array]
    def []
      [y, x]
    end

    # @return [Vedeu::Position]
    def to_position
      Vedeu::Position.new(y, x)
    end

  end # PositionIndex

end # Vedeu
