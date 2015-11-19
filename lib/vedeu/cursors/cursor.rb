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

      # @param (see #initialize)
      # @return [Vedeu::Cursors::Cursor]
      def self.store(attributes = {})
        new(attributes).store
      end

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
      alias_method :==, :eql?

      # Moves the cursor down by one row.
      #
      #   Vedeu.trigger(:_cursor_down_, name)
      #   Vedeu.trigger(:_cursor_down_, Vedeu.focus)
      #
      # @return [Vedeu::Cursors::Cursor]
      def move_down
        @oy += 1
        @y = coordinate(oy, :y).y

        store_and_refresh
      end

      # Moves the cursor left by one column.
      #
      #   Vedeu.trigger(:_cursor_left_, name)
      #   Vedeu.trigger(:_cursor_left_, Vedeu.focus)
      #
      # @return [Vedeu::Cursors::Cursor]
      def move_left
        @ox -= 1
        @x = coordinate(ox, :x).x

        store_and_refresh
      end

      # Moves the cursor to the top left of the named interface.
      #
      #   Vedeu.trigger(:_cursor_origin_, name)
      #   Vedeu.trigger(:_cursor_origin_, Vedeu.focus)
      #
      # @return [Vedeu::Cursors::Cursor]
      def move_origin
        @x = bx
        @y = by
        @ox = 0
        @oy = 0

        store
      end

      # Moves the cursor right by one column.
      #
      #   Vedeu.trigger(:_cursor_right_, name)
      #   Vedeu.trigger(:_cursor_right_, Vedeu.focus)
      #
      # @return [Vedeu::Cursors::Cursor]
      def move_right
        @ox += 1
        @x = coordinate(ox, :x).x

        store_and_refresh
      end

      # Moves the cursor up by one row.
      #
      #   Vedeu.trigger(:_cursor_up_, name)
      #   Vedeu.trigger(:_cursor_up_, Vedeu.focus)
      #
      # @return [Vedeu::Cursors::Cursor]
      def move_up
        @oy -= 1
        @y = coordinate(oy, :y).y

        store_and_refresh
      end

      # Renders the cursor.
      #
      # @return [Array<Vedeu::Models::Escape>]
      def render
        Vedeu.log(type: :output, message: "Refreshing cursor: '#{name}'".freeze)

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
      # @return [String]
      def to_s
        return escape_sequence.to_s unless block_given?

        "#{position}#{yield}#{escape_sequence}".freeze
      end
      alias_method :to_str, :to_s

      # Hide a named cursor, or without a name, the cursor of the
      # currently focussed interface.
      #
      # @example
      #   Vedeu.trigger(:_hide_cursor_, name)
      #   Vedeu.trigger(:_hide_cursor_, Vedeu.focus)
      #   Vedeu.trigger(:_hide_cursor_)
      #   Vedeu.hide_cursor(name)
      #   Vedeu.hide_cursor(Vedeu.focus)
      #   Vedeu.hide_cursor
      #
      # @return [Vedeu::Models::Escape]
      def hide
        super

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
        @position = Vedeu::Geometries::Position[y, x]
      end

      # Show a named cursor, or without a name, the cursor of the
      # currently focussed interface.
      #
      # @example
      #   Vedeu.trigger(:_show_cursor_, name)
      #   Vedeu.trigger(:_show_cursor_, Vedeu.focus)
      #   Vedeu.trigger(:_show_cursor_)
      #   Vedeu.show_cursor(name)
      #   Vedeu.show_cursor(Vedeu.focus)
      #   Vedeu.show_cursor
      #
      # @return [Vedeu::Models::Escape]
      def show
        super

        render
      end

      # @return [Fixnum] The column/character coordinate.
      def x
        @x = (@x < bx) ? bx : @x
        @x = (@x > bxn) ? bxn : @x
        @x
      end

      # @return [Fixnum] The row/line coordinate.
      def y
        @y = (@y < by) ? by : @y
        @y = (@y > byn) ? byn : @y
        @y
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
      # @return [Vedeu::Geometries::Coordinate]
      def coordinate(offset, type)
        Vedeu::Geometries::Coordinate.new(name:   name,
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

      # @return [Vedeu::Models::Escape]
      def escape_sequence
        Vedeu::Models::Escape.new(position: position, value: visibility)
      end

      # @return [Hash<Symbol => Fixnum>]
      def new_attributes(new_y = y, new_x = x, new_oy = oy, new_ox = ox)
        attributes.merge!(x: new_x, y: new_y, ox: new_ox, oy: new_oy)
      end

      # Store the cursor and refresh the cursor.
      #
      # @return [void]
      def store_and_refresh
        store

        Vedeu.trigger(:_refresh_cursor_, name)

        self
      end

      # Returns the escape sequence for setting the visibility of the
      # cursor.
      #
      # @return [String]
      def visibility
        return Vedeu::EscapeSequences::Esc.show_cursor if visible?

        Vedeu::EscapeSequences::Esc.hide_cursor
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

  # See {file:docs/events/visibility.md#\_hide_cursor_}
  Vedeu.bind(:_hide_cursor_) { |name| Vedeu.hide_cursor(name) }
  # Vedeu.bind_alias(:_cursor_hide_, :_hide_cursor_)

  # See {file:docs/events/visibility.md#\_show_cursor_}
  Vedeu.bind(:_show_cursor_) { |name| Vedeu.show_cursor(name) }
  # Vedeu.bind_alias(:_cursor_show_, :_show_cursor_)

  # See {file:docs/events/visibility.md#\_toggle_cursor_}
  Vedeu.bind(:_toggle_cursor_) { |name| Vedeu.toggle_cursor(name) }

  # See {file:docs/cursors.md}
  Vedeu.bind(:_cursor_left_) do |name|
    Vedeu.cursors.by_name(name).tap do |cursor|
      cursor.move_left if cursor.visible?
    end
  end

  # See {file:docs/cursors.md}
  Vedeu.bind(:_cursor_down_) do |name|
    Vedeu.cursors.by_name(name).tap do |cursor|
      cursor.move_down if cursor.visible?
    end
  end

  # See {file:docs/cursors.md}
  Vedeu.bind(:_cursor_up_) do |name|
    Vedeu.cursors.by_name(name).tap do |cursor|
      cursor.move_up if cursor.visible?
    end
  end

  # See {file:docs/cursors.md}
  Vedeu.bind(:_cursor_right_) do |name|
    Vedeu.cursors.by_name(name).tap do |cursor|
      cursor.move_right if cursor.visible?
    end
  end

  # See {file:docs/cursors.md}
  Vedeu.bind(:_cursor_origin_) do |name|
    Vedeu.cursors.by_name(name).move_origin

    Vedeu.trigger(:_refresh_cursor_, name)
  end
  # Vedeu.bind_alias(:_cursor_reset_, :_cursor_origin_)

  # See {file:docs/cursors.md}
  Vedeu.bind(:_cursor_position_) do |name|
    Vedeu.cursors.by_name(name).to_a
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
