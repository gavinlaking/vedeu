module Vedeu

  # Repository for storing, retrieving and manipulating the cursor position and
  # visibility for an interface.
  #
  # @api private
  module Cursors

    include Repository
    include Positional
    extend self

    # System events which when called will update the cursor visibility
    # accordingly for the interface in focus.
    Vedeu.event(:_cursor_hide_) { Cursors.hide }
    Vedeu.event(:_cursor_show_) { Cursors.show }

    # Make the cursor of this interface invisible.
    #
    # @return [Cursor]
    def hide
      find_or_create(Focus.current).hide
    end

    # Make the cursor of this interface visible.
    #
    # @return [Cursor]
    def show
      find_or_create(Focus.current).show
    end

    private

    # @return [Class] The model class for this repository.
    def model
      Vedeu::Cursor
    end
    alias_method :entity, :model

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
