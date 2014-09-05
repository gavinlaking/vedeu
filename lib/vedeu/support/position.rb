module Vedeu

  # Change coordinates into an escape sequence to set the cursor position.
  class Position

    # @param y [Fixnum]
    # @param x [Fixnum]
    # @return [Position]
    def initialize(y = 1, x = 1)
      @y, @x = y, x
    end

    # Returns an escape sequence to position the cursor. When passed a block,
    # will position the cursor, yield and return the original position.
    #
    # @param block [Proc]
    # @return [String]
    def to_s(&block)
      if block_given?
        [ sequence, yield, sequence ].join

      else
        sequence

      end
    end

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
