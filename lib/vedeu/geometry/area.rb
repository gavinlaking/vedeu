module Vedeu

  # Define an area from dimensions or points.
  #
  class Area

    # @!attribute [r] y
    # @return [Fixnum]
    attr_reader :y
    alias_method :top, :y

    # @!attribute [r] yn
    # @return [Fixnum]
    attr_reader :yn
    alias_method :bottom, :yn

    # @!attribute [r] x
    # @return [Fixnum]
    attr_reader :x
    alias_method :left, :x

    # @!attribute [r] xn
    # @return [Fixnum]
    attr_reader :xn
    alias_method :right, :xn

    # @param height [Fixnum]
    # @param width [Fixnum]
    # @return [Vedeu::Area]
    def self.from_dimensions(height:, width:)
      new(y: 1, yn: height, x: 1, xn: width)
    end

    # @param (see #initialize)
    # @return [Vedeu::Area]
    def self.from_points(y:, yn:, x:, xn:)
      new(y: y, yn: yn, x: x, xn: xn)
    end

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
    def ==(other)
      eql?(other)
    end

    # @param other [Vedeu::Area]
    # @return [Boolean]
    def eql?(other)
      self.class == other.class &&
      y          == other.y     &&
      yn         == other.yn    &&
      x          == other.x     &&
      xn         == other.xn
    end

    # @return [Array<Fixnum>]
    def centre
      [centre_y, centre_x]
    end

    # @return [Fixnum]
    def centre_y
      ((yn - y) / 2) + y
    end

    # @return [Fixnum]
    def centre_x
      ((xn - x) / 2) + x
    end

    # Returns the row above the top by default.
    #
    # @example
    #   `top` / `y` is 4.
    #
    #   north     # => 3
    #   north(2)  # => 2
    #   north(-4) # => 8
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
    #   east(2)  # => 21
    #   east(-4) # => 15
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
    #   south(2)  # => 14
    #   south(-4) # => 8
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
    #   west(2)   # => 6
    #   west(-4)  # => 12
    #
    # @param offset [Fixnum]
    # @return [Fixnum]
    def west(offset = 1)
      x - offset
    end

    private

  end # Area

end # Vedeu
