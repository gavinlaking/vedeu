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
      # @return [String|Symbol]
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
        self.class == other.class && name == other.name
      end
      alias == eql?

      # @return [String]
      def inspect
        "name:'#{name}' x:#{x} y:#{y} ox:#{ox} oy:#{oy} visible:#{visible}"
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
      # @param block [Proc]
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
        @ox = @ox < 0 ? 0 : @ox
      end

      # @return [Fixnum]
      def oy
        @oy = @oy < 0 ? 0 : @oy
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

      # Returns the geometry for the interface.
      #
      # @return (see Vedeu::Geometries::Repository#by_name)
      def geometry
        @geometry ||= Vedeu.geometries.by_name(name)
      end

      # Determine correct x and y related coordinates.
      #
      # @return [Vedeu::Cursors::Coordinate]
      def coordinate(offset, type)
        Vedeu::Cursors::Coordinate.new(name:   name,
                                       offset: offset,
                                       type:   type)
      end

      # The default values for a new instance of this class.
      #
      # @return [Hash<Symbol => Boolean|Fixnum|String|
      #   Vedeu::Cursors::Repository>]
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

      # @return [Vedeu::Cells::Cursor]
      def escape_sequence
        Vedeu::Cells::Cursor.new(position: position, value: visibility)
      end

      # @return [Hash<Symbol => Fixnum>]
      def new_attributes(new_y = y, new_x = x, new_oy = oy, new_ox = ox)
        attributes.merge!(x: new_x, y: new_y, ox: new_ox, oy: new_oy)
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

  # @!method hide_cursor
  #   @see Vedeu::Toggleable::ClassMethods.hide
  # @!method show_cursor
  #   @see Vedeu::Toggleable::ClassMethods#show
  # @!method toggle_cursor
  #   @see Vedeu::Toggleable::ClassMethods#toggle
  def_delegators Vedeu::Cursors::Cursor,
                 :hide_cursor,
                 :show_cursor,
                 :toggle_cursor

  # :nocov:

  # See {file:docs/cursors.md#vedeuhide_cursor__}
  Vedeu.bind(:_hide_cursor_) { |name| Vedeu.hide_cursor(name) }
  Vedeu.bind_alias(:_cursor_hide_, :_hide_cursor_)

  # See {file:docs/cursors.md#vedeushow_cursor__}
  Vedeu.bind(:_show_cursor_) { |name| Vedeu.show_cursor(name) }
  Vedeu.bind_alias(:_cursor_show_, :_show_cursor_)

  # See {file:docs/cursors.md#vedeutoggle_cursor__}
  Vedeu.bind(:_toggle_cursor_) { |name| Vedeu.toggle_cursor(name) }

  # See {file:docs/events/by_name/cursor_left.md}
  Vedeu.bind(:_cursor_left_) do |name, offset|
    Vedeu::Cursors::Move.move(name, :move_left, offset)
  end

  # See {file:docs/events/by_name/cursor_down.md}
  Vedeu.bind(:_cursor_down_) do |name, offset|
    Vedeu::Cursors::Move.move(name, :move_down, offset)
  end

  # See {file:docs/events/by_name/cursor_up.md}
  Vedeu.bind(:_cursor_up_) do |name, offset|
    Vedeu::Cursors::Move.move(name, :move_up, offset)
  end

  # See {file:docs/events/by_name/cursor_right.md}
  Vedeu.bind(:_cursor_right_) do |name, offset|
    Vedeu::Cursors::Move.move(name, :move_right, offset)
  end

  # See {file:docs/cursors.md}
  Vedeu.bind(:_cursor_origin_) do |name|
    Vedeu.cursors.by_name(name).move_origin

    Vedeu.trigger(:_refresh_cursor_, name)
  end
  Vedeu.bind_alias(:_cursor_reset_, :_cursor_origin_)

  # See {file:docs/cursors.md}
  Vedeu.bind(:_cursor_position_) do |name|
    Vedeu.cursors.by_name(name).inspect
  end

  # See {file:docs/cursors.md}
  Vedeu.bind(:_cursor_reposition_) do |name, y, x|
    Vedeu::Cursors::Reposition.new(name: name,
                                   y:    y,
                                   x:    x,
                                   mode: :absolute).reposition
  end

  # See {file:docs/cursors.md}
  Vedeu.bind(:_cursor_top_) do |name|
    name ||= Vedeu.focus

    Vedeu::Cursors::Reposition.new(name: name,
                                   y:    0,
                                   x:    0,
                                   mode: :relative).reposition

    Vedeu.trigger(:_clear_view_, name)
    Vedeu.trigger(:_refresh_view_, name)
  end

  # See {file:docs/cursors.md}
  Vedeu.bind(:_cursor_bottom_) do |name|
    name ||= Vedeu.focus
    count = Vedeu.buffers.by_name(name).size

    Vedeu::Cursors::Reposition.new(name: name,
                                   y:    count,
                                   x:    0,
                                   mode: :relative).reposition

    Vedeu.trigger(:_clear_view_, name)
    Vedeu.trigger(:_refresh_view_, name)
  end

  # :nocov:

end # Vedeu
