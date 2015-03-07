module Vedeu

  # Change coordinates into an escape sequence to set the cursor position.
  #
  class Position

    # @!attribute [r] y
    # @return [Fixnum]
    attr_reader :y

    # @!attribute [r] x
    # @return [Fixnum]
    attr_reader :x

    alias_method :first, :y
    alias_method :last, :x

    # @param value [Array<Fixnum>|Vedeu::Position]
    # @return [void]
    def self.coerce(value)
      if value.is_a?(self)
        value

      elsif value.is_a?(Array)
        new(*value)

      elsif value.is_a?(Hash)
        new(value.fetch(:y, 1), value.fetch(:x, 1))

      else
        # not sure how to proceed

      end
    end

    # Initializes a new instance of Position.
    #
    # @param y [Fixnum] The row/line position.
    # @param x [Fixnum] The column/character position.
    # @return [Position]
    def initialize(y = 1, x = 1)
      @y = (y.nil? || y < 1) ? 1 : y
      @x = (x.nil? || x < 1) ? 1 : x
    end

    # @param other [Vedeu::Position]
    # @return [Boolean]
    def ==(other)
      eql?(other)
    end

    # @param other [Vedeu::Position]
    # @return [Boolean]
    def eql?(other)
      self.class == other.class && (x == other.x && y == other.y)
    end

    # Return the escape sequence required to position the cursor at a particular
    # point on the screen. When passed a block, will do the aforementioned,
    # call the block and then reposition to this location.
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

  end # Position

end # Vedeu
