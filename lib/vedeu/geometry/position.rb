module Vedeu

  # Change coordinates into an escape sequence to set the cursor position.
  #
  class Position

    # @!attribute [r] y
    # @return [Fixnum]
    attr_reader :y
    alias_method :first, :y

    # @!attribute [r] x
    # @return [Fixnum]
    attr_reader :x
    alias_method :last, :x

    # Convenience constructor for Vedeu::Position.
    #
    # @param (see #initialize)
    def self.[](y, x)
      new(y, x)
    end

    # @param value [Array<Fixnum>|Vedeu::Position]
    # @return [void]
    def self.coerce(value)
      if value.is_a?(self)
        value

      elsif value.is_a?(Array)
        new(*value)

      elsif value.is_a?(Hash)
        new(value.fetch(:y, 1), value.fetch(:x, 1))

      end
    end

    # Initializes a new instance of Vedeu::Position.
    #
    # @param y [Fixnum] The row/line position.
    # @param x [Fixnum] The column/character position.
    # @return [Vedeu::Position]
    def initialize(y = 1, x = 1)
      @y = (y.nil? || y < 1) ? 1 : y
      @x = (x.nil? || x < 1) ? 1 : x
    end

    # Converts a position into an index for the terminal. An index is the
    # position minus 1.
    #
    # @return [Array<Fixnum>]
    def as_indices
      xi = ((x - 1) <= 1) ? 0 : (x - 1)
      yi = ((y - 1) <= 1) ? 0 : (y - 1)

      [yi, xi]
    end

    # @param other [Vedeu::Position]
    # @return [Fixnum]
    def <=>(other)
      if y == other.y
        x <=> other.x

      else
        y <=> other.y

      end
    end

    # An object is equal when its values are the same.
    #
    # @param other [Vedeu::Position]
    # @return [Boolean]
    def eql?(other)
      self.class == other.class && (x == other.x && y == other.y)
    end
    alias_method :==, :eql?

    # Return a tuple containing the y and x coordinates.
    #
    # @return [Array<Fixnum>]
    def to_a
      [y, x]
    end

    # @return [Vedeu::Position]
    def to_position
      self
    end

    # Return the escape sequence required to position the cursor at a particular
    # point on the screen. When passed a block, will do the aforementioned,
    # call the block and then reposition to this location.
    #
    # @return [String]
    # @yieldreturn [void] Returns the block wrapped in position escape
    #   sequences.
    def to_s
      return "#{sequence}#{yield}" if block_given?

      sequence
    end
    alias_method :to_str, :to_s

    # Increase y coordinate; moves down.
    #
    # @return [Vedeu::Position]
    def down
      Vedeu::Position.new(y + 1, x)
    end

    # Decrease x coordinate; moves left.
    #
    # @return [Vedeu::Position]
    def left
      Vedeu::Position.new(y, x - 1)
    end

    # Increase x coordinate; moves right.
    #
    # @return [Vedeu::Position]
    def right
      Vedeu::Position.new(y, x + 1)
    end

    # Decrease y coordinate; moves up.
    #
    # @return [Vedeu::Position]
    def up
      Vedeu::Position.new(y - 1, x)
    end

    private

    # Returns the escape sequence to reposition the cursors at the coordinates
    # specified by x and y.
    #
    # @return [String]
    def sequence
      "\e[#{y};#{x}H"
    end

  end # Position

end # Vedeu
