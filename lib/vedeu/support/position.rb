module Vedeu

  # Change coordinates into an escape sequence to set the cursor position.
  # Also used as the basis of an Offset.
  #
  # @api private
  class Position < Array

    # Initializes a new instance of Position.
    #
    # @param y [Fixnum]
    # @param x [Fixnum]
    # @return [Position]
    def initialize(y = 0, x = 0)
      super([y, x])
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

    # Returns the escape sequence to reposition the cursors at the coordinates
    # specified by x and y. If either of these values are 0, then we use 1,
    # as ANSI terminals do not have a 0, 0 coordinate.
    #
    # @return [String]
    def sequence
      ["\e[", (y == 0 ? 1 : y), ';', (x == 0 ? 1 : x), 'H'].join
    end

    # Returns the y coordinate. Can be 0 as this class may also be used as an
    # Offset.
    #
    # @return [Fixnum]
    def y
      (first == nil) ? 0 : first
    end

    # Returns the x coordinate. Can be 0 as this class may also be used as an
    # Offset.
    #
    # @return [Fixnum]
    def x
      (last == nil) ? 0 : last
    end

  end # Position

end # Vedeu
