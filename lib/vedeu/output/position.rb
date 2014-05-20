module Vedeu
  class Position
    class << self
      def set(y = 0, x = 0)
        new(y, x).set
      end
      alias_method :reset, :set
    end

    def initialize(y = 0, x = 0)
      @y, @x = y, x
    end

    def set
      [esc, (y + 1), ';', (x + 1), 'H'].join
    end

    private

    attr_accessor :y, :x

    def esc
      Esc.esc
    end
  end
end
