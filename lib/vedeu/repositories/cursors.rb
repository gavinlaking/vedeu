module Vedeu

  # Repository for storing, retrieving and manipulating the cursor position and
  # visibility for an interface.
  #
  # @api private
  module Cursors

    include Repository
    extend self

    # Return the Cursor for the interface by name.
    #
    # @param name [String] The name of the interface which owns this cursor.
    # @return [Cursor]
    def by_name(name)
      return find(name) if registered?(name)

      model.new(name).store
    end

    # Return the Cursor for the interface currently in focus.
    #
    # @return [Cursor]
    def current
      return find(Focus.current) if registered?(Focus.current)

      model.new(Focus.current).store
    end

    private

    # Returns an empty collection ready for the storing of cursors by name with
    # current attributes.
    #
    # @return [Hash]
    def in_memory
      {}
    end

    # @return [Class] The model class for this repository.
    def model
      Vedeu::Cursor
    end

  end # Cursors

end # Vedeu
