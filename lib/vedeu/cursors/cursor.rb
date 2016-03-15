# frozen_string_literal: true

module Vedeu

  module Cursors

    # Each interface has its own Cursor which maintains the position
    # and visibility of the cursor within that interface.
    #
    # @api private
    #
    class Cursor

      include Vedeu::Repositories::Model
      include Vedeu::Toggleable
      extend Forwardable

      def_delegators :geometry,
                     :bx,
                     :bxn,
                     :by,
                     :byn

      # @!attribute [r] name
      # @macro return_name
      attr_reader :name

      # @!attribute [w] ox
      # @return [Fixnum]
      attr_writer :ox

      # @!attribute [w] oy
      # @return [Fixnum]
      attr_writer :oy

      # @!attribute [w] x
      # @return [Fixnum]
      attr_writer :x

      # @!attribute [w] y
      # @return [Fixnum]
      attr_writer :y

      # Returns a new instance of Vedeu::Cursors::Cursor.
      #
      # @param attributes [Hash<Symbol => Boolean|Fixnum|String|
      #   Vedeu::Cursors::Repository>]
      # @option attributes name [String|Symbol] The name of the
      #   interface this cursor belongs to.
      # @option attributes ox [Fixnum] The offset x coordinate.
      # @option attributes oy [Fixnum] The offset y coordinate.
      # @option attributes repository
      #   [Vedeu::Repositories::Repository]
      # @option attributes visible [Boolean] The visibility of the
      #   cursor.
      # @option attributes x [Fixnum] The terminal x coordinate for
      #   the cursor.
      # @option attributes y [Fixnum] The terminal y coordinate for
      #   the cursor.
      # @return [Vedeu::Cursors::Cursor]
      def initialize(attributes = {})
        defaults.merge!(attributes).each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # @return [Hash<Symbol => Boolean|Fixnum|String|
      #   Vedeu::Cursors::Repository>]
      def attributes
        {
          name:       @name,
          ox:         ox,
          oy:         oy,
          repository: @repository,
          visible:    @visible,
          x:          x,
          y:          y,
        }
      end

      # An object is equal when its values are the same.
      #
      # @param other [Vedeu::Cursors::Cursor]
      # @return [Boolean]
      def eql?(other)
        self.class.equal?(other.class) && name == other.name
      end
      alias == eql?

      # @return [String]
      def inspect
        "name: #{name.inspect} x: #{x} y: #{y} ox: #{ox} oy: #{oy} " \
        "visible: #{visible}"
      end

      # {include:file:docs/events/by_name/cursor_down.md}
      # @return [Vedeu::Cursors::Cursor]
      def move_down(offset = 1)
        @oy += offset || 1
        @y = coordinate(oy, :y).y

        self
      end

      # {include:file:docs/events/by_name/cursor_left.md}
      # @return [Vedeu::Cursors::Cursor]
      def move_left(offset = 1)
        @ox -= offset || 1
        @x = coordinate(ox, :x).x

        self
      end

      # {include:file:docs/events/by_name/cursor_origin.md}
      # @return [Vedeu::Cursors::Cursor]
      def move_origin
        @x = bx
        @y = by
        @ox = 0
        @oy = 0

        store
      end

      # {include:file:docs/events/by_name/cursor_right.md}
      # @return [Vedeu::Cursors::Cursor]
      def move_right(offset = 1)
        @ox += offset || 1
        @x = coordinate(ox, :x).x

        self
      end

      # {include:file:docs/events/by_name/cursor_up.md}
      # @return [Vedeu::Cursors::Cursor]
      def move_up(offset = 1)
        @oy -= offset || 1
        @y = coordinate(oy, :y).y

        self
      end

      # Renders the cursor.
      #
      # @return [Array<Vedeu::Cells::Cursor>]
      def render
        Vedeu.render_output(escape_sequence)
      end

      # @return [Array<Fixnum>]
      def to_a
        position.to_a
      end

      # Returns an escape sequence to position the cursor and set its
      # visibility. When passed a block, will position the cursor,
      # yield and return the original position.
      #
      # @macro param_block
      # @return [String]
      def to_s(&block)
        return escape_sequence.to_s unless block_given?

        "#{position}#{yield}#{escape_sequence}"
      end
      alias to_str to_s

      # {include:file:docs/events/by_name/hide_cursor.md}
      # @return [Vedeu::Cells::Cursor]
      def hide
        super

        Vedeu.log(type: :cursor, message: "Hiding cursor: '#{name}'")

        render
      end

      # @return [Fixnum]
      def ox
        @ox = @ox < 1 ? 1 : @ox
      end

      # @return [Fixnum]
      def oy
        @oy = @oy < 1 ? 1 : @oy
      end

      # Return the position of this cursor.
      #
      # @return [Vedeu::Geometries::Position]
      def position
        @position = Vedeu::Geometries::Position.new(y, x)
      end

      # {include:file:docs/events/by_name/show_cursor.md}
      # @return [Vedeu::Cells::Cursor]
      def show
        super

        Vedeu.log(type: :cursor, message: "Showing cursor: '#{name}'")

        render
      end

      # @return [Fixnum] The column/character coordinate.
      def x
        @x = Vedeu::Point.coerce(value: @x, min: bx, max: bxn).value
      end

      # @return [Fixnum] The row/line coordinate.
      def y
        @y = Vedeu::Point.coerce(value: @y, min: by, max: byn).value
      end

      private

      # @macro geometry_by_name
      def geometry
        @_geometry ||= Vedeu.geometries.by_name(name)
      end

      # Determine correct x and y related coordinates.
      #
      # @return [Vedeu::Cursors::Coordinate]
      def coordinate(offset, type)
        Vedeu::Cursors::Coordinate.new(geometry: geometry,
                                       offset:   offset,
                                       type:     type)
      end

      # @macro defaults_method
      def defaults
        {
          name:       nil,
          ox:         1,
          oy:         1,
          repository: Vedeu.cursors,
          visible:    false,
          x:          1,
          y:          1,
        }
      end

      # @return [Vedeu::Cells::Cursor]
      def escape_sequence
        Vedeu::Cells::Cursor.new(position: position, value: visibility)
      end

      # Returns the escape sequence for setting the visibility of the
      # cursor.
      #
      # @return [String]
      def visibility
        return Vedeu.esc.show_cursor if visible?

        Vedeu.esc.hide_cursor
      end

    end # Cursor

  end # Cursors

  # @api public
  # @!method hide_cursor
  #   @see Vedeu::Toggleable::SingletonMethods.hide
  # @api public
  # @!method show_cursor
  #   @see Vedeu::Toggleable::SingletonMethods#show
  # @api public
  # @!method toggle_cursor
  #   @see Vedeu::Toggleable::SingletonMethods#toggle
  def_delegators Vedeu::Cursors::Cursor,
                 :hide_cursor,
                 :show_cursor,
                 :toggle_cursor

end # Vedeu
