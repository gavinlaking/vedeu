# frozen_string_literal: true

module Vedeu

  module Geometries

    # Define an area from dimensions or points.
    #
    # @api private
    #
    class Area

      extend Forwardable

      def_delegators :border,
                     :bottom?,
                     :enabled?,
                     :left?,
                     :right?,
                     :top?

      # @!attribute [r] y
      # @return [Integer] Returns the top coordinate (row/line start
      #   position) of the interface.
      attr_reader :y
      alias top y

      # @!attribute [r] yn
      # @return [Integer] Returns the bottom coordinate (row/line end
      #   position) of the interface.
      attr_reader :yn
      alias bottom yn

      # @!attribute [r] x
      # @return [Integer] Returns the left coordinate (column/character
      #   start position) of the interface.
      attr_reader :x
      alias left x

      # @!attribute [r] xn
      # @return [Integer] Returns the right coordinate (column/
      #   character end position) of the interface.
      attr_reader :xn
      alias right xn

      # @param attributes [Hash<Symbol => Boolean|Integer|Symbol>]
      # @option attributes horizontal_alignment [Symbol]
      # @option attributes maximised [Boolean]
      # @option attributes name [String|Symbol]
      # @option attributes vertical_alignment [Symbol]
      # @option attributes x [Integer] The starting x coordinate.
      # @option attributes xn [Integer] The ending x coordinate.
      # @option attributes width [Integer]
      # @option attributes y [Integer] The starting y coordinate.
      # @option attributes yn [Integer] The ending y coordinate.
      # @option attributes height [Integer]
      # @return [Vedeu::Geometries::Area]
      def self.from_attributes(attributes = {})
        y_attributes = {
          alignment: attributes[:vertical_alignment],
          d:         attributes[:y],
          dn:        attributes[:yn],
          d_dn:      attributes[:height],
          maximised: attributes[:maximised],
        }
        x_attributes = {
          alignment: attributes[:horizontal_alignment],
          d:         attributes[:x],
          dn:        attributes[:xn],
          d_dn:      attributes[:width],
          maximised: attributes[:maximised],
        }
        dy, dyn = Vedeu::Geometries::YDimension.pair(y_attributes)
        dx, dxn = Vedeu::Geometries::XDimension.pair(x_attributes)

        new(name: attributes[:name],
            y:    dy,
            yn:   dyn,
            x:    dx,
            xn:   dxn)
      end

      # Returns a new instance of Vedeu::Area.
      #
      # @macro param_name
      # @param y [Integer] The starting row/line position.
      # @param yn [Integer] The ending row/line position.
      # @param x [Integer] The starting column/character position.
      # @param xn [Integer] The ending column/character position.
      # @return [Vedeu::Geometries::Area]
      def initialize(name:, y:, yn:, x:, xn:)
        @name = name
        @y    = y
        @yn   = yn
        @x    = x
        @xn   = xn
      end

      # An object is equal when its values are the same.
      #
      # @param other [Vedeu::Geometries::Area]
      # @return [Boolean]
      def eql?(other)
        self.class.equal?(other.class) &&
          name == other.name &&
          y == other.y &&
          yn == other.yn &&
          x == other.x &&
          xn == other.xn
      end
      alias == eql?

      # Returns the width of the interface determined by whether a
      # left, right, both or neither borders are shown.
      #
      # @return [Integer]
      def bordered_width
        return width unless border && enabled?

        if left? && right?
          width - 2

        elsif left? || right?
          width - 1

        else
          width

        end
      end

      # Returns the height of the interface determined by whether a
      # top, bottom, both or neither borders are shown.
      #
      # @return [Integer]
      def bordered_height
        return height unless border && enabled?

        if top? && bottom?
          height - 2

        elsif top? || bottom?
          height - 1

        else
          height

        end
      end

      # Return the column position for 1 character right of the left
      #   border.
      #
      # @return [Integer]
      def bx
        (enabled? && left?) ? x + 1 : x
      end

      # Return the column position for 1 character left of the right
      #   border.
      #
      # @return [Integer]
      def bxn
        (enabled? && right?) ? xn - 1 : xn
      end

      # Return the row position for 1 character under of the top
      #   border.
      #
      # @return [Integer]
      def by
        (enabled? && top?) ? y + 1 : y
      end

      # Return the column position for 1 character above of the bottom
      #   border.
      #
      # @return [Integer]
      def byn
        (enabled? && bottom?) ? yn - 1 : yn
      end

      # Returns an array containing the centred y and x coordinates of
      # the interface.
      #
      # @return [Array<Integer>]
      def centre
        [centre_y, centre_x]
      end

      # Returns the centred y coordinate (the vertical centre row) of
      # the interface.
      #
      # @return [Integer]
      def centre_y
        (height / 2) + y
      end

      # Returns the centred x coordinate (the horizontal centre
      # character) of the interface.
      #
      # @return [Integer]
      def centre_x
        (width / 2) + x
      end

      # Returns the height of the interface.
      #
      # @return [Integer]
      def height
        (yn - y) + 1
      end

      # Returns the width of the interface.
      #
      # @return [Integer]
      def width
        (xn - x) + 1
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
      # @param offset [Integer]
      # @return [Integer]
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
      # @param offset [Integer]
      # @return [Integer]
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
      # @param offset [Integer]
      # @return [Integer]
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
      # @param offset [Integer]
      # @return [Integer]
      def west(offset = 1)
        x - offset
      end

      protected

      # @!attribute [r] name
      # @macro return_name
      attr_reader :name

      private

      # @macro border_by_name
      def border
        @_border ||= Vedeu.borders.by_name(name)
      end

    end # Area

  end # Geometries

end # Vedeu
