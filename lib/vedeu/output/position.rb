module Vedeu
  class Position
    class << self
      def set(y = nil, x = nil)
        return '' if y.nil? || x.nil?

        new(y, x).set
      end

      def reset
        new(0, 0).set
      end
    end

    def initialize(y = nil, x = nil)
      @y, @x = y, x
    end

    def set
      [Esc.esc, (y + 1), ';', (x + 1), 'H'].join
    end

    private

    attr_accessor :y, :x
  end
end
