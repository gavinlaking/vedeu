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

    # Find cursor by named interface, registers an cursor by interface name if
    # not found.
    #
    # @param name [String]
    # @return [Cursor]
    def find(name)
      storage.fetch(name) do
        Vedeu.log("Cursor not found, registering new for: '#{name}'")

        storage.store(name, Cursor.new({ name: name }))
      end
    end

    # Make the cursor of this interface invisible.
    #
    # @return [Cursor]
    def hide
      find(Focus.current).hide
    end

    # Move the cursor of this interface.
    #
    # @param y [Fixnum]
    # @param x [Fixnum]
    # @return [Cursor]
    def move(y, x)
      find(Focus.current).move(y, x)
    end

    # Make the cursor of this interface visible.
    #
    # @return [Cursor]
    def show
      find(Focus.current).show
    end

    private

    # @param method [Symbol]
    # @return [String]
    def action(method)
      return 'Registering' if method == :add

      'Updating'
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
