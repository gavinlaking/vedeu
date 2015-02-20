module Vedeu

  class PositionIndex

    attr_reader :y, :x
    alias_method :first, :y
    alias_method :last, :x

    def self.[](y, x)
      new(y, x).[]
    end

    def initialize(y, x)
      @y = [(y - 1), 1].max
      @x = [(x - 1), 1].max
    end

    def []
      [y, x]
    end

  end # PositionIndex

end # Vedeu
