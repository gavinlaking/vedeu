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

    # @param attributes [Hash]
    # @option attributes y [Fixnum]
    # @option attributes yn [Fixnum]
    # @option attributes y_yn [Fixnum]
    # @option attributes y_default [Fixnum]
    # @option attributes x [Fixnum]
    # @option attributes xn [Fixnum]
    # @option attributes x_xn [Fixnum]
    # @option attributes x_default [Fixnum]
    # @option attributes options [Hash<Symbol => Boolean>]
    # @return [Vedeu::Area]
    def self.from_attributes(attributes = {})
      y_yn = Vedeu::Dimension.pair(d:       attributes[:y],
                                   dn:      attributes[:yn],
                                   d_dn:    attributes[:y_yn],
                                   default: attributes[:y_default],
                                   maximised: attributes[:maximised],
                                   centred: attributes[:centred])
      x_xn = Vedeu::Dimension.pair(d:       attributes[:x],
                                   dn:      attributes[:xn],
                                   d_dn:    attributes[:x_xn],
                                   default: attributes[:x_default],
                                   maximised: attributes[:maximised],
                                   centred: attributes[:centred])

      new(y: y_yn.first, yn: y_yn.last, x: x_xn.first, xn: x_xn.last)
    end

    # Returns a new instance of Vedeu::Area.
    #
    # @param y [Fixnum]
    # @param yn [Fixnum]
    # @param x [Fixnum]
    # @param xn [Fixnum]
    # @return [Vedeu::Area]
    def initialize(y:, yn:, x:, xn:)
      @y  = y
      @yn = yn
      @x  = x
      @xn = xn
    end

    # An object is equal when its values are the same.
    #
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
    #   `top` or `y` is 4.
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
    #   `right` or `xn` is 19.
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
    #   `bottom` or `yn` is 12.
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
    #   `left` or `x` is 8.
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

  end # Area

end # Vedeu
