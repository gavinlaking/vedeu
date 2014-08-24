module Vedeu
  class Position

    # @param []
    # @param []
    # @return []
    def initialize(y = 1, x = 1)
      @y, @x = y, x
    end

    # @param []
    # @return []
    def to_s(&block)
      if block_given?
        [ sequence, yield, sequence ].join

      else
        sequence

      end
    end

    private

    def sequence
      ["\e[", y, ';', x, 'H'].join
    end

    def y
      (@y == 0 || @y == nil) ? 1 : @y
    end

    def x
      (@x == 0 || @x == nil) ? 1 : @x
    end

  end
end
