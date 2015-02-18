module Vedeu

  # Change coordinates into an escape sequence to set the cursor position.
  #
  # @api private
  class Position

    attr_reader  :y,
      :x

    alias_method :first, :y
    alias_method :last, :x

    def self.coerce(value)
      if value.is_a?(self)
        value

      elsif value.is_a?(Array)
        new(*value)

      else
        # not sure how to proceed

      end
    end

    # Initializes a new instance of Position.
    #
    # @param y [Fixnum]
    # @param x [Fixnum]
    # @return [Position]
    def initialize(y = 1, x = 1)
      @y = y
      @x = x
    end

    def inspect
      "<#{self.class.name} (y:#{@y} x:#{@x})>"
    end

    # @param other []
    # @return [Boolean]
    def ==(other)
      eql?(other)
    end

    # @param other []
    # @return [Boolean]
    def eql?(other)
      self.class == other.class && (x == other.x && y == other.y)
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
    # specified by x and y.
    #
    # @return [String]
    def sequence
      ["\e[", y, ';', x, 'H'].join
    end

    # Returns the y coordinate.
    #
    # @return [Fixnum]
    def y
      if @y < 1 || @y.nil?
        1

      else
        @y

      end
    end

    # Returns the x coordinate.
    #
    # @return [Fixnum]
    def x
      if @x < 1 || @x.nil?
        1

      else
        @x

      end
    end

  end # Position

end # Vedeu
