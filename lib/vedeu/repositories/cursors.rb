module Vedeu

  # Repository for storing, retrieving and manipulating the cursor position and
  # visibility for an interface.
  #
  # @api private
  module Cursors

    include Common
    include Repository
    extend self

    # System events which when called will update the cursor visibility
    # accordingly for the interface in focus.
    Vedeu.event(:_cursor_hide_)    { Cursors.hide }
    Vedeu.event(:_cursor_show_)    { Cursors.show }

    # Adds an interface to the cursors repository.
    #
    # @param attributes [Hash]
    # @return [Hash]
    def add(attributes)
      validate_attributes!(attributes)

      Vedeu.log("#{action(__callee__)} cursor: '#{attributes[:name]}'")

      storage.store(attributes[:name], Cursor.new(attributes))
    end
    alias_method :update, :add

    # Make the cursor of this interface invisible.
    #
    # @return [Cursor]
    def hide
      find_or_create(Focus.current).hide
    end

    # Move the cursor of this interface.
    #
    # @param y [Fixnum]
    # @param x [Fixnum]
    # @return [Cursor]
    def move(y, x)
      find_or_create(Focus.current).move(y, x)
    end

    # Make the cursor of this interface visible.
    #
    # @return [Cursor]
    def show
      find_or_create(Focus.current).show
    end

    private

    # @return [Class]
    def entity
      Cursor
    end

    # Returns an empty collection ready for the storing of cursors by name with
    # current attributes.
    #
    # @example
    #   { 'holmium' => {
    #                    name:     'holmium',
    #                    state:    :show,
    #                    x:        1,
    #                    y:        1 } }
    #
    # @return [Hash]
    def in_memory
      {}
    end

  end # Cursors

end # Vedeu
