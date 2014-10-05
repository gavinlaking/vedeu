module Vedeu

  # Each interface has its own Cursor which maintains the position and
  # visibility of the cursor within that interface.
  #
  # @api private
  class Cursor

    attr_reader :name, :x, :y

    # Provides a new instance of Cursor.
    #
    # @param attributes [Hash] The stored attributes for a cursor.
    # @option attributes :name [String] The name of the interface this cursor
    #   belongs to.
    # @option attributes :state [Symbol] The visibility of the cursor, either
    #   +:hide+ or +:show+.
    # @option attributes :x [Fixnum]
    # @option attributes :y [Fixnum]
    #
    # @return [Cursor]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)

      @name       = @attributes[:name]
      @state      = @attributes[:state]
      @x          = @attributes[:x]
      @y          = @attributes[:y]
    end

    # Returns an attribute hash for the current position and visibility of the
    # cursor.
    #
    # @return [Hash]
    def attributes
      {
        name:     name,
        state:    state,
        x:        x,
        y:        y,
      }
    end
    alias_method :refresh, :attributes

    # Saves the attributes to the Cursors repository.
    #
    # @return []
    def update
      Cursors.update(attributes)
    end

    # Move the cursor up one row.
    #
    # @return [Cursor]
    def move_up
      @y -= 1

      update
    end

    # Move the cursor down one row.
    #
    # @return [Cursor]
    def move_down
      @y += 1

      update
    end

    # Move the cursor left one column.
    #
    # @return [Cursor]
    def move_left
      @x -= 1

      update
    end

    # Move the cursor right one column.
    #
    # @return [Cursor]
    def move_right
      @x += 1

      update
    end

    # Make the cursor visible if it is not already.
    #
    # @return [Symbol]
    def show
      @state = :show

      update
    end

    # Make the cursor invisible if it is not already.
    #
    # @return [Symbol]
    def hide
      @state = :hide

      update
    end

    # Toggle the visibility of the cursor.
    #
    # @return [Symbol]
    def toggle
      if visible?
        @state = :hide

      else
        @state = :show

      end

      update
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

    # Return a boolean indicating the visibility of the cursor, invisible if
    # the state is not defined.
    #
    # @api private
    # @return [Boolean]
    def visible?
      return false unless states.include?(state)
      return false if state == :hide

      true
    end

    private

    attr_reader :state

    # Returns the escape sequence to position the cursor and set its visibility.
    #
    # @return [String]
    def sequence
      [ position, visibility ].join
    end

    # Returns the escape sequence to position the cursor.
    #
    # @return [String]
    def position
      ["\e[", y, ';', x, 'H'].join
    end

    # Returns the escape sequence for setting the visibility of the cursor.
    #
    # @return [String]
    def visibility
      return Esc.string('show_cursor') if visible?

      Esc.string('hide_cursor')
    end

    # The valid visibility states for the cursor.
    #
    # @return [Array]
    def states
      [:show, :hide]
    end

    # The default values for a new instance of Cursor.
    #
    # @return [Hash]
    def defaults
      {
        name:     '',
        state:    :hide,
        x:        1,
        y:        1,
      }
    end

  end # Cursor

end # Vedeu
