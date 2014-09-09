module Vedeu

  # Stores and manipulates the position of the current cursor.
  #
  # @api private
  class Cursor

    # @return [Hash]
    attr_reader :attributes

    # @return [Fixnum]
    attr_reader :top

    # @return [Fixnum]
    attr_reader :bottom

    # @return [Fixnum]
    attr_reader :left

    # @return [Fixnum]
    attr_reader :right

    # @return [Fixnum]
    attr_reader :cursor_x

    # @return [Fixnum]
    attr_reader :cursor_y

    # @return [TrueClass|FalseClass]
    attr_reader :visible

    # Provides a new instance of Cursor.
    #
    # @param attributes [Hash]
    # @return [Cursor]
    def initialize(attributes = {})
      @attributes = attributes

      @top        = attributes.fetch(:top)
      @bottom     = attributes.fetch(:bottom)
      @left       = attributes.fetch(:left)
      @right      = attributes.fetch(:right)
      @cursor_y   = attributes.fetch(:cursor_y, @top)
      @cursor_x   = attributes.fetch(:cursor_x, @left)
      @visible    = attributes.fetch(:visible, false)
    end

    # Reports the position of the cursor.
    #
    # @return [Array]
    def position
      [ @cursor_y, @cursor_x ]
    end

    # Move the cursor up one row.
    #
    # @return [Cursor]
    def move_up
      unless @cursor_y == top || @cursor_y - 1 < top
        @cursor_y -= 1
      end

      self
    end

    # Move the cursor down one row.
    #
    # @return [Cursor]
    def move_down
      unless @cursor_y == bottom || @cursor_y + 1 > bottom
        @cursor_y += 1
      end

      self
    end

    # Move the cursor left one column.
    #
    # @return [Cursor]
    def move_left
      unless @cursor_x == left || @cursor_x - 1 < left
        @cursor_x -= 1
      end

      self
    end

    # Move the cursor right one column.
    #
    # @return [Cursor]
    def move_right
      unless @cursor_x == right || @cursor_x + 1 > right
        @cursor_x += 1
      end

      self
    end

    # Make the cursor visible if it is not already.
    #
    # @return [Cursor]
    def show_cursor
      @visible = true

      self
    end

    # Make the cursor invisible if it is not already.
    #
    # @return [Cursor]
    def hide_cursor
      @visible = false

      self
    end
  end
end
