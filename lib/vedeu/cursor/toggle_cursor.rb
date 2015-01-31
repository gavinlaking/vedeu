require 'vedeu/cursor/cursor'
require 'vedeu/support/visible'

module Vedeu

  # Adjusts the visibility of the cursor.
  #
  class ToggleCursor

    # @param cursor [Cursor]
    # @return [ToggleCursor]
    def initialize(cursor)
      @cursor = cursor
    end

    # Hides the cursor.
    #
    # @param cursor [Cursor]
    # @return [Cursor]
    def self.hide(cursor)
      new(cursor).hide
    end

    # Shows the cursor.
    #
    # @param cursor [Cursor]
    # @return [Cursor]
    def self.show(cursor)
      new(cursor).show
    end

    # Hides the cursor.
    #
    # @return [Cursor]
    def hide
      Cursor.new({ name:  cursor.name,
                   ox:    cursor.ox,
                   oy:    cursor.oy,
                   state: Visible.new(false),
                   x:     cursor.x,
                   y:     cursor.y }).store
    end

    # Shows the cursor.
    #
    # @return [Cursor]
    def show
      Cursor.new({ name:  cursor.name,
                   ox:    cursor.ox,
                   oy:    cursor.oy,
                   state: Visible.new(true),
                   x:     cursor.x,
                   y:     cursor.y }).store
    end

    private

    attr_reader :cursor

  end # ToggleCursor

end # Vedeu
