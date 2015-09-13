module Vedeu

  module Cursors

    # Each interface has its own Cursor which maintains the position and
    # visibility of the cursor within that interface.
    #
    class Cursor

      include Vedeu::Model
      include Vedeu::Toggleable
      extend Forwardable

      def_delegators :border,
                     :bx,
                     :bxn,
                     :by,
                     :byn

      # @!attribute [r] attributes
      # @return [Hash]
      attr_reader :attributes

      # @!attribute [r] name
      # @return [String]
      attr_reader :name

      # @!attribute [w] ox
      # @return [Fixnum]
      attr_writer :ox

      # @!attribute [w] oy
      # @return [Fixnum]
      attr_writer :oy

      # @!attribute [r] state
      # @return [Boolean|Symbol]
      attr_reader :state

      # @!attribute [w] x
      # @return [Fixnum]
      attr_writer :x

      # @!attribute [w] y
      # @return [Fixnum]
      attr_writer :y

      # Returns a new instance of Vedeu::Cursors::Cursor.
      #
      # @param attributes [Hash]
      # @option attributes name [String] The name of the interface this cursor
      #   belongs to.
      # @option attributes ox [Fixnum] The offset x coordinate.
      # @option attributes oy [Fixnum] The offset y coordinate.
      # @option attributes repository [Vedeu::Repository]
      # @option attributes visible [Boolean] The visibility of the cursor.
      # @option attributes x [Fixnum] The terminal x coordinate for the cursor.
      # @option attributes y [Fixnum] The terminal y coordinate for the cursor.
      #
      # @return [Vedeu::Cursors::Cursor]
      def initialize(attributes = {})
        @attributes = defaults.merge!(attributes)

        @attributes.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # Moves the cursor down by one row.
      #
      # @return [Vedeu::Cursors::Cursor]
      def move_down
        @oy += 1

        @attributes = attributes.merge!(x:  x,
                                        y:  coordinate.y_position,
                                        ox: ox,
                                        oy: oy)

        Vedeu::Cursors::Cursor.new(@attributes).store
      end

      # Moves the cursor left by one column.
      #
      # @return [Vedeu::Cursors::Cursor]
      def move_left
        @ox -= 1

        @attributes = attributes.merge!(x:  coordinate.x_position,
                                        y:  y,
                                        ox: ox,
                                        oy: oy)

        Vedeu::Cursors::Cursor.new(@attributes).store
      end

      # Moves the cursor to the top left of the named interface.
      #
      # @return [Vedeu::Cursors::Cursor]
      def move_origin
        @attributes = attributes.merge!(x: bx, y: by, ox: 0, oy: 0)

        Vedeu::Cursors::Cursor.new(@attributes).store
      end

      # Moves the cursor right by one column.
      #
      # @return [Vedeu::Cursors::Cursor]
      def move_right
        @ox += 1

        @attributes = attributes.merge!(x:  coordinate.x_position,
                                        y:  y,
                                        ox: ox,
                                        oy: oy)

        Vedeu::Cursors::Cursor.new(@attributes).store
      end

      # Moves the cursor up by one row.
      #
      # @return [Vedeu::Cursors::Cursor]
      def move_up
        @oy -= 1

        @attributes = attributes.merge!(x:  x,
                                        y:  coordinate.y_position,
                                        ox: ox,
                                        oy: oy)

        Vedeu::Cursors::Cursor.new(@attributes).store
      end

      # Renders the cursor.
      #
      # @return [Array<Vedeu::Escape>]
      def render
        Vedeu::Output.render(visibility)
      end

      # Arbitrarily move the cursor to a given position.
      #
      # @param new_y [Fixnum] The row/line position.
      # @param new_x [Fixnum] The column/character position.
      # @return [Vedeu::Cursors::Cursor]
      def reposition(new_y, new_x)
        @attributes = attributes.merge!(x:  coordinate.x_position,
                                        y:  coordinate.y_position,
                                        ox: new_x,
                                        oy: new_y)

        Vedeu::Cursors::Cursor.new(@attributes).store
      end

      # Returns an escape sequence to position the cursor and set its
      # visibility. When passed a block, will position the cursor, yield and
      # return the original position.
      #
      # @return [String]
      def to_s
        if block_given?
          "#{position}#{yield}#{visibility}"

        else
          "#{visibility}"

        end
      end
      alias_method :to_str, :to_s

      # Hide a named cursor, or without a name, the cursor of the currently
      # focussed interface.
      #
      # @example
      #   Vedeu.hide_cursor(name)
      #
      # @return [Vedeu::Escape]
      def hide
        super

        render
      end

      # @return [Fixnum]
      def ox
        @ox = 0 if @ox < 0
        @ox
      end

      # @return [Fixnum]
      def oy
        @oy = 0 if @oy < 0
        @oy
      end

      # Return the position of this cursor.
      #
      # @return [Vedeu::Geometry::Position]
      def position
        @position = Vedeu::Geometry::Position[y, x]
      end

      # Show a named cursor, or without a name, the cursor of the currently
      # focussed interface.
      #
      # @example
      #   Vedeu.show_cursor(name)
      #
      # @return [Vedeu::Escape]
      def show
        super

        render
      end

      # @return [Fixnum] The column/character coordinate.
      def x
        @x = bx  if @x < bx
        @x = bxn if @x > bxn

        @attributes[:x] = @x

        @x
      end

      # @return [Fixnum] The row/line coordinate.
      def y
        @y = by  if @y < by
        @y = byn if @y > byn

        @attributes[:y] = @y

        @y
      end

      private

      # @see Vedeu::Borders::Repository#by_name
      def border
        @border ||= Vedeu.borders.by_name(name)
      end

      # @return [Vedeu::Geometry::Coordinate]
      def coordinate
        @coordinate ||= Vedeu::Geometry::Coordinate.new(name, oy, ox)
      end

      # The default values for a new instance of this class.
      #
      # @return [Hash]
      def defaults
        {
          name:       '',
          ox:         0,
          oy:         0,
          repository: Vedeu.cursors,
          visible:    false,
          x:          1,
          y:          1,
        }
      end

      # Returns the escape sequence for setting the visibility of the cursor.
      #
      # @return [String]
      def visibility
        value = visible? ? Vedeu::Esc.show_cursor : Vedeu::Esc.hide_cursor

        Vedeu::Escape.new(position: position, value: value)
      end

    end # Cursor

  end # Cursors

end # Vedeu
