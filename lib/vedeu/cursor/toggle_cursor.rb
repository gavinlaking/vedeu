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
      return cursor if cursor.invisible?

      new(cursor).hide
    end

    # Shows the cursor.
    #
    # @param cursor [Cursor]
    # @return [Cursor]
    def self.show(cursor)
      return cursor if cursor.visible?

      new(cursor).show
    end

    # Hides the cursor.
    #
    # @return [Cursor]
    def hide
      cursor.class.new(cursor.attributes.merge!({ state: false })).store
    end

    # Shows the cursor.
    #
    # @return [Cursor]
    def show
      cursor.class.new(cursor.attributes.merge!({ state: true })).store
    end

    private

    attr_reader :cursor

  end # ToggleCursor

end # Vedeu
