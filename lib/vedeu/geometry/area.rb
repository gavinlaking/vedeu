module Vedeu

  # Define an area from dimensions or points.
  #
  class Area

    # @!attribute [r] y
    # @return [Fixnum] Returns the top coordinate of the interface.
    attr_reader :y
    alias_method :top, :y

    # @!attribute [r] yn
    # @return [Fixnum] Returns the bottom coordinate of the interface.
    attr_reader :yn
    alias_method :bottom, :yn

    # @!attribute [r] x
    # @return [Fixnum] Returns the left coordinate of the interface.
    attr_reader :x
    alias_method :left, :x

    # @!attribute [r] xn
    # @return [Fixnum] Returns the right coordinate of the interface.
    attr_reader :xn
    alias_method :right, :xn

    # @param y_yn [Array<Fixnum>]
    # @param x_xn [Array<Fixnum>]
    # @return [Vedeu::Area]
    def self.from_dimensions(y_yn:, x_xn:)
      new(y: y_yn.first, yn: y_yn.last, x: x_xn.first, xn: x_xn.last)
    end

    # @param height [Fixnum]
    # @param width [Fixnum]
    # @return [Vedeu::Area]
    def self.from_height_and_width(height:, width:)
      new(y: 1, yn: height, x: 1, xn: width)
    end

    # @param (see #initialize)
    # @return [Vedeu::Area]
    def self.from_points(y:, yn:, x:, xn:)
      new(y: y, yn: yn, x: x, xn: xn)
    end

    # Returns a new instance of Vedeu::Area.
    #
    # @param y [Fixnum]
    # @param yn [Fixnum]
    # @param x [Fixnum]
    # @param xn [Fixnum]
    # @return [Vedeu::Area]
    def initialize(y:, yn:, x:, xn:)
      @y, @yn, @x, @xn  = y, yn, x, xn
    end

    # @param other [Vedeu::Area]
    # @return [Boolean]
    def eql?(other)
      self.class == other.class && y == other.y && yn == other.yn &&
        x == other.x && xn == other.xn
    end
    alias_method :==, :eql?

    # @return [Array<Fixnum>]
    def centre
      [centre_y, centre_x]
    end

    # @return [Fixnum]
    def centre_y
      (height / 2) + y
    end

    # @return [Fixnum]
    def centre_x
      (width / 2) + x
    end

    # @return [Fixnum]
    def height
      (y..yn).size
    end

    # @return [Fixnum]
    def width
      (x..xn).size
    end

    # Returns the row above the top by default.
    #
    # @example
    #   `top` / `y` is 4.
    #
    #   north     # => 3
    #   north(2)  # => 2 (positive goes north)
    #   north(-4) # => 8 (negative goes south)
    #
    # @param offset [Fixnum]
    # @return [Fixnum]
    def north(offset = 1)
      y - offset
    end

    # Returns the column after right by default.
    #
    # @example
    #   `right` / `xn` is 19.
    #
    #   east     # => 20
    #   east(2)  # => 21 (positive goes east)
    #   east(-4) # => 15 (negative goes west)
    #
    # @param offset [Fixnum]
    # @return [Fixnum]
    def east(offset = 1)
      xn + offset
    end

    # Returns the row below the bottom by default.
    #
    # @example
    #   `bottom` / `yn` is 12.
    #
    #   south     # => 13
    #   south(2)  # => 14 (positive goes south)
    #   south(-4) # => 8  (negative goes north)
    #
    # @param offset [Fixnum]
    # @return [Fixnum]
    def south(offset = 1)
      yn + offset
    end

    # Returns the column before left by default.
    #
    # @example
    #   `left` / `x` is 8.
    #
    #   west      # => 7
    #   west(2)   # => 6  (positive goes west)
    #   west(-4)  # => 12 (negative goes east)
    #
    # @param offset [Fixnum]
    # @return [Fixnum]
    def west(offset = 1)
      x - offset
    end

    # @return [Vedeu::Position]
    def top_left
      Vedeu::Position[y, x]
    end

    # @return [Vedeu::Position]
    def bottom_left
      Vedeu::Position[yn, x]
    end

    # @return [Vedeu::Position]
    def top_right
      Vedeu::Position[y, xn]
    end

    # @return [Vedeu::Position]
    def bottom_right
      Vedeu::Position[yn, xn]
    end

  end # Area

end # Vedeu
