module Vedeu

  class PositionIndex

    attr_reader :y,
      :x

    alias_method :first, :y
    alias_method :last, :x

    # @param y [Fixnum]
    # @param x [Fixnum]
    # @return [Array]
    def self.[](y, x)
      new(y, x).[]
    end

    # @param y [Fixnum]
    # @param x [Fixnum]
    # @return [Vedeu::PositionIndex]
    def initialize(y, x)
      @y = [(y - 1), 1].max
      @x = [(x - 1), 1].max
    end

    # @return [Array]
    def []
      [y, x]
    end

  end # PositionIndex

end # Vedeu
