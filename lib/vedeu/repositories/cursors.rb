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

      Vedeu.log("Registering cursor: '#{attributes[:name]}'")

      interface = Interface.new(attributes)

      storage.store(attributes[:name], {
        name:     attributes[:name],
        state:    :hide,
        x:        interface.left,
        y:        interface.top,
      })
    end

    # Create an instance of Cursor from the stored attributes.
    #
    # @param name [String]
    # @return [Cursor]
    def build(name)
      Cursor.new(find(name))
    end

    # @return [Cursor]
    def hide
      find(Focus.current).hide
    end

    # @param y [Fixnum]
    # @param x [Fixnum]
    # @return [Cursor]
    def move(y, x)
      find(Focus.current).move(y, x)
    end

    # @return [Cursor]
    def show
      find(Focus.current).show
    end

    # Saves the attributes in the repository for future use.
    #
    # @param attributes [Hash]
    # @return [Hash]
    def update(attributes)
      return false unless defined_value?(attributes[:name])

      Vedeu.log("Updating cursor: '#{attributes[:name]}'")

      old = find(attributes[:name])

      storage.store(attributes[:name], old.merge!(attributes))
    end

    private

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

    # @param name [String]
    # @raise [CursorNotFound] When the entity cannot be found with this name.
    # @return [CursorNotFound]
    def not_found(name)
      fail CursorNotFound, "Cursor was not found with this name: #{name.to_s}."
    end

  end # Cursors

end # Vedeu
