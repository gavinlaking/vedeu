module Vedeu

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

    # @!attribute [rw] ox
    # @return [Fixnum]
    attr_accessor :ox

    # @!attribute [rw] oy
    # @return [Fixnum]
    attr_accessor :oy

    # @!attribute [r] state
    # @return [Boolean|Symbol]
    attr_reader :state

    # @!attribute [w] x
    # @return [Fixnum]
    attr_writer :x

    # @!attribute [sw] y
    # @return [Fixnum]
    attr_writer :y

    # Returns a new instance of Vedeu::Cursor.
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
    # @return [Vedeu::Cursor]
    def initialize(attributes = {})
      # @todo Hack because Repository#by_name creates Cursor objects with just a
      #   name. Intend to remove this.
      attributes = { name: attributes } if attributes.is_a?(String)

      @attributes = defaults.merge!(attributes)

      @attributes.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    # Override Ruby's Object#inspect method to provide a more helpful output.
    #
    # @return [String]
    def inspect
      "<Vedeu::Cursor (#{name}, " \
      "#{visible}, "              \
      "x:#{x}, "                  \
      "y:#{y}, "                  \
      "ox:#{ox}, "                \
      "oy:#{oy})>"
    end

    # Returns an escape sequence to position the cursor and set its visibility.
    # When passed a block, will position the cursor, yield and return the
    # original position.
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

      Vedeu::Output.render(visibility)
    end

    # Return the position of this cursor.
    #
    # @return [Vedeu::Position]
    def position
      @position = Vedeu::Position[y, x]
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

      Vedeu::Output.render(visibility)
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

    # @see Vedeu::Borders#by_name
    def border
      @border ||= Vedeu.borders.by_name(name)
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
      if visible?
        Vedeu::Escape.new(position: position, value: Vedeu::Esc.show_cursor)

      else
        Vedeu::Escape.new(position: position, value: Vedeu::Esc.hide_cursor)

      end
    end

  end # Cursor

end # Vedeu
