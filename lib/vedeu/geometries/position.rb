# frozen_string_literal: true

module Vedeu

  module Geometries

    # Change coordinates into an escape sequence to set the cursor
    # position.
    #
    # @api private
    #
    class Position

      # @!attribute [r] y
      # @return [Integer]
      attr_reader :y
      alias first y

      # @!attribute [r] x
      # @return [Integer]
      attr_reader :x
      alias last x

      class << self

        extend Forwardable

        def_delegators Vedeu::Coercers::Position,
                       :coerce

        # Convenience constructor for Vedeu::Geometries::Position.
        #
        # @param (see #initialize)
        def [](y = 1, x = 1)
          new(y, x)
        end

      end # Eigenclass

      # Initializes a new instance of Vedeu::Geometries::Position.
      #
      # @param y [Integer] The row/line position.
      # @param x [Integer] The column/character position.
      # @return [Vedeu::Geometries::Position]
      def initialize(y = 1, x = 1)
        @y = Vedeu::Point.coerce(value: y, max: Vedeu.height).value
        @x = Vedeu::Point.coerce(value: x, max: Vedeu.width).value

        freeze
      end

      # Converts a position into an index for the terminal. An index
      # is the position minus 1.
      #
      # @return [Array<Integer>]
      def as_indices
        ix = Vedeu::Point.coerce(value: (x - 1), min: 0).value
        iy = Vedeu::Point.coerce(value: (y - 1), min: 0).value

        [iy, ix]
      end

      # @param other [Vedeu::Geometries::Position]
      # @return [Integer]
      def <=>(other)
        if y == other.y
          x <=> other.x

        else
          y <=> other.y

        end
      end

      # An object is equal when its values are the same.
      #
      # @param other [Vedeu::Geometries::Position]
      # @return [Boolean]
      def eql?(other)
        self.class.equal?(other.class) && x == other.x && y == other.y
      end
      alias == eql?

      # Return a tuple containing the y and x coordinates.
      #
      # @return [Array<Integer>]
      def to_a
        [y, x]
      end

      # @return [String]
      def to_ast
        ":y#{y}_x#{x}"
      end

      # Return the position as a Hash.
      #
      # @return [Hash<Symbol => Integer|NilClass>]
      def to_h
        {
          position: {
            y: y,
            x: x,
          },
        }
      end
      alias to_hash to_h

      # Return the escape sequence required to position the cursor at
      # a particular point on the screen. When passed a block, will do
      # the aforementioned, call the block and then reposition to this
      # location.
      #
      # @macro param_block
      # @return [String]
      # @yieldreturn [String] Returns the block wrapped in position
      #   escape sequences.
      def to_s(&block)
        return "#{sequence}#{yield}" if block_given?

        sequence
      end
      alias to_str to_s

      # Increase y coordinate; moves down.
      #
      # @return [Vedeu::Geometries::Position]
      def down
        Vedeu::Geometries::Position.new(y + 1, x)
      end

      # Decrease x coordinate; moves left.
      #
      # @return [Vedeu::Geometries::Position]
      def left
        Vedeu::Geometries::Position.new(y, x - 1)
      end

      # Increase x coordinate; moves right.
      #
      # @return [Vedeu::Geometries::Position]
      def right
        Vedeu::Geometries::Position.new(y, x + 1)
      end

      # Decrease y coordinate; moves up.
      #
      # @return [Vedeu::Geometries::Position]
      def up
        Vedeu::Geometries::Position.new(y - 1, x)
      end

      private

      # Returns the escape sequence to reposition the cursors at the
      # coordinates specified by x and y.
      #
      # @return [String]
      def sequence
        "\e[#{y};#{x}H"
      end

    end # Position

  end # Geometries

end # Vedeu
