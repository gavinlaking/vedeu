require 'vedeu/models/cursor'
require 'vedeu/support/terminal'

module Vedeu

  # Adjusts the visibility of the cursor.
  #
  class ToggleCursor

    # @param cursor  [Cursor]
    # @return [ToggleCursor]
    def initialize(cursor)
      @cursor  = cursor
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
      Cursor.new(cursor.name, Visible.new(false), cursor.x, cursor.y).store
    end

    # Shows the cursor.
    #
    # @return [Cursor]
    def show
      Cursor.new(cursor.name, Visible.new(true), cursor.x, cursor.y).store
    end

    private

    attr_reader :cursor

  end # ToggleCursor

end # Vedeu
