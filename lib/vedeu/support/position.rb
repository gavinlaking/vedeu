module Vedeu
  class Position

    # @param y [Fixnum]
    # @param x [Fixnum]
    # @return [Position]
    def initialize(y = 1, x = 1)
      @y, @x = y, x
    end

    # @param block [Proc]
    # @return [String]
    def to_s(&block)
      if block_given?
        [ sequence, yield, sequence ].join

      else
        sequence

      end
    end
    alias_method :render, :to_s

    private

    # @api private
    # @return [String]
    def sequence
      ["\e[", y, ';', x, 'H'].join
    end

    # @api private
    # @return [Fixnum]
    def y
      (@y == 0 || @y == nil) ? 1 : @y
    end

    # @api private
    # @return [Fixnum]
    def x
      (@x == 0 || @x == nil) ? 1 : @x
    end

  end
end
