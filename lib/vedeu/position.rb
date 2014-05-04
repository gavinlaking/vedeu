module Vedeu
  class Position
    class << self
      def [](y, x)
        pos_y = y.nil? ? 0 : y
        pos_x = x.nil? ? 0 : x
        new(pos_y, pos_x)
      end
    end

    def initialize(y, x)
      @y, @x = y, x
    end

    def locate
      [y, x]
    end

    def x
      @x
    end
    alias_method :column, :x

    def y
      @y
    end
    alias_method :row, :y
  end
end
