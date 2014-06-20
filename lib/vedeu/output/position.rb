module Vedeu
  class Position
    class << self
      def set(y = nil, x = nil)
        return '' if y.nil? || x.nil?

        new(y, x).set
      end

      def reset
        new(1, 1).set
      end
    end

    def initialize(y = 1, x = 1)
      @y, @x = y, x
    end

    def set
      [Esc.esc, y, ';', x, 'H'].join
    end

    private

    attr_accessor :y, :x

    def y
      @y == 0 ? 1 : @y
    end

    def x
      @x == 0 ? 1 : @x
    end
  end
end
