module Vedeu

  # Stores and manipulates the position of the current cursor.
  #
  # @api private
  class Cursor

    # Provides a new instance of Cursor.
    #
    # @param interface [Interface]
    # @return [Cursor]
    def initialize(interface)
      @interface = interface
    end

    # Returns an attributes hash containing the state of the instance.
    #
    # @return [Hash]
    def attributes
      {
        visible: visible,
        x:       cursor_x,
        y:       cursor_y,
      }
    end

    # Returns the y coordinate of the cursor.
    #
    # @return [Fixnum]
    def cursor_y
      @cursor_y ||= top
    end

    # Returns the x coordinate of the cursor.
    #
    # @return [Fixnum]
    def cursor_x
      @cursor_x ||= left
    end

    # Reports the position of the cursor.
    #
    # @return [Array]
    def position
      [ cursor_y, cursor_x ]
    end

    # Returns a boolean indicating the visibility of the cursor.
    #
    # @return [Boolean]
    def visible
      @visible ||= false
    end
    alias_method :visible?, :visible

    # Move the cursor up one row.
    #
    # @return [Cursor]
    def move_up
      unless cursor_y == top || cursor_y - 1 < top
        @cursor_y -= 1
      end

      self
    end

    # Move the cursor down one row.
    #
    # @return [Cursor]
    def move_down
      unless cursor_y == bottom || cursor_y + 1 > bottom
        @cursor_y += 1
      end

      self
    end

    # Move the cursor left one column.
    #
    # @return [Cursor]
    def move_left
      unless cursor_x == left || cursor_x - 1 < left
        @cursor_x -= 1
      end

      self
    end

    # Move the cursor right one column.
    #
    # @return [Cursor]
    def move_right
      unless cursor_x == right || cursor_x + 1 > right
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

    attr_reader :interface

    # Returns the top coordinate of the interface.
    #
    # @api private
    # @return [Fixnum]
    def top
      interface.top
    end

    # Returns the right coordinate of the interface.
    #
    # @api private
    # @return [Fixnum]
    def right
      interface.right
    end

    # Returns the bottom coordinate of the interface.
    #
    # @api private
    # @return [Fixnum]
    def bottom
      interface.bottom
    end

    # Returns the left coordinate of the interface.
    #
    # @api private
    # @return [Fixnum]
    def left
      interface.left
    end

    # Returns the escape sequence to position the cursor and set its visibility.
    #
    # @api private
    # @return [String]
    def sequence
      position_sequence + visibility_sequence
    end

    # Returns the escape sequence to position the cursor.
    #
    # @api private
    # @return [String]
    def position_sequence
      ["\e[", cursor_y, ';', cursor_x, 'H'].join
    end

    # Returns the escape sequence for setting the visibility of the cursor.
    #
    # @api private
    # @return [String]
    def visibility_sequence
      return show_sequence if visible?

      hide_sequence
    end

    # Returns the escape sequence to show the cursor.
    #
    # @api private
    # @return [String]
    def show_sequence
      Esc.string('show_cursor')
    end

    # Returns the escape sequence to hide the cursor.
    #
    # @api private
    # @return [String]
    def hide_sequence
      Esc.string('hide_cursor')
    end

  end
end
