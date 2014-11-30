module Vedeu

  # Repository for storing, retrieving and manipulating the cursor position and
  # visibility for an interface.
  #
  # @api private
  module Cursors

    include Repository
    extend self

    # Add or update the cursor coordinates.
    #
    # @param attributes [Hash]
    # @return [Offset]
    def add(attributes)
      validate_attributes!(attributes)

      Vedeu.log("#{action(__callee__)} positional (#{entity}): " \
                "'#{attributes[:name]}'")

      storage.store(attributes[:name], entity.new(attributes))
    end
    alias_method :update, :add

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
