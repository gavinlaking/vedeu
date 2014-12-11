module Vedeu

  # Each interface has its own Cursor which maintains the position and
  # visibility of the cursor within that interface.
  #
  # @api private
  class Cursor

    include Model
    extend Forwardable

    def_delegators :interface, :top, :right, :bottom, :left

    attr_reader :name, :state

    # Provides a new instance of Cursor.
    #
    # @param attributes [Hash] The stored attributes for a cursor.
    # @option attributes :name [String] The name of the interface this cursor
    #   belongs to.
    # @option attributes :state [Symbol] The visibility of the cursor, either
    #   +:hide+ or +:show+.
    # @option attributes :x [Fixnum] The terminal x coordinate for the cursor.
    # @option attributes :y [Fixnum] The terminal y coordinate for the cursor.
    #
    # @return [Cursor]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)

      @name  = @attributes[:name]
      @state = @attributes[:state]
      @x     = @attributes[:x]
      @y     = @attributes[:y]
    end

    # Returns an attribute hash for the current position and visibility of the
    # cursor.
    #
    # @return [Hash]
    def attributes
      {
        name:  name,
        state: state,
        x:     x,
        y:     y,
      }
    end
    alias_method :refresh, :attributes

    # Returns the x coordinate (column/character) of the cursor. Attempts to
    # sensibly reposition the cursor if it is currently outside the interface,
    # or outside the visible area of the terminal.
    #
    # @return [Fixnum]
    def x
      @x = 1              if @x <= 1
      @x = Terminal.width if @x >= Terminal.width

      if @x <= left
        @x = left

      elsif @x >= right
        @x = right - 1

      else
        @x

      end
    end

    # Returns the y coordinate (row/line) of the cursor. Attempts to sensibly
    # reposition the cursor if it is currently outside the interface, or outside
    # the visible area of the terminal.
    #
    # @return [Fixnum]
    def y
      @y = 1               if @y <= 1
      @y = Terminal.height if @y >= Terminal.height

      if @y <= top
        @y = top

      elsif @y >= bottom
        @y = bottom - 1

      else
        @y

      end
    end

    # Make the cursor visible.
    #
    # @return [Hash]
    def show
      @state = :show

      store
    end

    # Make the cursor invisible.
    #
    # @return [Hash]
    def hide
      @state = :hide

      store
    end

    # Returns an escape sequence to position the cursor and set its visibility.
    # When passed a block, will position the cursor, yield and return the
    # original position.
    #
    # @param block [Proc]
    # @return [String]
    def to_s(&block)
      if block_given?
        [ sequence, yield, sequence ].join

      else
        sequence

      end
    end

    private

    # @return [Class] The repository class for this model.
    def repository
      Vedeu::Cursors
    end

    # Returns the escape sequence to position the cursor and set its visibility.
    #
    # @return [String]
    def sequence
      [ position, visibility ].join
    end

    # Returns the escape sequence for setting the position of the cursor.
    #
    # @return [String]
    def position
      @_position ||= Position.new(y, x).to_s
    end

    # Returns the escape sequence for setting the visibility of the cursor.
    #
    # @return [String]
    def visibility
      return Esc.string('show_cursor') if state == :show

      Esc.string('hide_cursor')
    end

    # Returns an instance of the associated interface for this cursor, used to
    # ensure that {x} and {y} are still 'inside' the interface. A cursor could
    # be 'outside' the interface if the terminal has resized, causing the
    # geometry of an interface to change and therefore invalidating the cursor's
    # position.
    #
    # @api private
    # @return [Interface]
    def interface
      @interface ||= Interfaces.build(name)
    end

    # The default values for a new instance of Cursor.
    #
    # @return [Hash]
    def defaults
      {
        name:  '',
        state: :hide,
        x:     1,
        y:     1,
      }
    end

  end # Cursor

end # Vedeu
