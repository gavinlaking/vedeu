module Vedeu

  module Geometry

    # Define an area from dimensions or points.
    #
    class Area

      # @!attribute [r] y
      # @return [Fixnum] Returns the top coordinate (row/line start
      #   position) of the interface.
      attr_reader :y
      alias_method :top, :y

      # @!attribute [r] yn
      # @return [Fixnum] Returns the bottom coordinate (row/line end
      #   position) of the interface.
      attr_reader :yn
      alias_method :bottom, :yn

      # @!attribute [r] x
      # @return [Fixnum] Returns the left coordinate (column/character
      #   start position) of the interface.
      attr_reader :x
      alias_method :left, :x

      # @!attribute [r] xn
      # @return [Fixnum] Returns the right coordinate (column/
      #   character end position) of the interface.
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
      # @option attributes maximised [Boolean]
      # @option attributes centred [Boolean]
      # @option attributes alignment [Symbol]
      # @return [Vedeu::Geometry::Area]
      def self.from_attributes(attributes = {})
        y_attributes = {
          d:         attributes[:y],
          dn:        attributes[:yn],
          d_dn:      attributes[:y_yn],
          default:   Vedeu.height,
          maximised: attributes[:maximised],
          centred:   attributes[:centred],
          # alignment: attributes[:alignment],
        }
        x_attributes = {
          d:         attributes[:x],
          dn:        attributes[:xn],
          d_dn:      attributes[:x_xn],
          default:   Vedeu.width,
          maximised: attributes[:maximised],
          centred:   attributes[:centred],
          alignment: attributes[:alignment],
        }
        y_yn = Vedeu::Geometry::Dimension.pair(y_attributes)
        x_xn = Vedeu::Geometry::Dimension.pair(x_attributes)

        new(y: y_yn[0], yn: y_yn[-1], x: x_xn[0], xn: x_xn[-1])
      end

      # Returns a new instance of Vedeu::Area.
      #
      # @param y [Fixnum] The starting row/line position.
      # @param yn [Fixnum] The ending row/line position.
      # @param x [Fixnum] The starting column/character position.
      # @param xn [Fixnum] The ending column/character position.
      # @return [Vedeu::Geometry::Area]
      def initialize(y:, yn:, x:, xn:)
        @y  = y
        @yn = yn
        @x  = x
        @xn = xn
      end

      # An object is equal when its values are the same.
      #
      # @param other [Vedeu::Geometry::Area]
      # @return [Boolean]
      def eql?(other)
        self.class == other.class && y == other.y && yn == other.yn &&
          x == other.x && xn == other.xn
      end
      alias_method :==, :eql?

      # Returns an array containing the centred y and x coordinates of
      # the interface.
      #
      # @return [Array<Fixnum>]
      def centre
        [centre_y, centre_x]
      end

      # Returns the centred y coordinate (the vertical centre row) of
      # the interface.
      #
      # @return [Fixnum]
      def centre_y
        (height / 2) + y
      end

      # Returns the centred x coordinate (the horizontal centre
      # character) of the interface.
      #
      # @return [Fixnum]
      def centre_x
        (width / 2) + x
      end

      # Returns the height of the interface.
      #
      # @return [Fixnum]
      def height
        (y..yn).size
      end

      # Returns the width of the interface.
      #
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
      #   north(2)  # => 2 (positive goes 'more' north)
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
      #   east(2)  # => 21 (positive goes 'more' east)
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
      #   south(2)  # => 14 (positive goes 'more' south)
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
      #   west(2)   # => 6  (positive goes 'more' west)
      #   west(-4)  # => 12 (negative goes east)
      #
      # @param offset [Fixnum]
      # @return [Fixnum]
      def west(offset = 1)
        x - offset
      end

    end # Area

  end # Geometry

end # Vedeu
