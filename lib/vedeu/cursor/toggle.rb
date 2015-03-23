module Vedeu

  # Adjusts the visibility of the cursor.
  #
  class Toggle

    # Returns an instance of Vedeu::Toggle.
    #
    # @param cursor [Cursor]
    # @return [Toggle]
    def initialize(cursor)
      @cursor = cursor
    end

    # Hides the cursor.
    #
    # @param (see #initialize)
    def self.hide(cursor)
      return cursor if cursor.invisible?

      new(cursor).hide
    end

    # Shows the cursor.
    #
    # @param (see #initialize)
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

    # @!attribute [r] cursor
    # @return [Vedeu::Cursor]
    attr_reader :cursor

  end # Toggle

end # Vedeu
