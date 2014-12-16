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

      Vedeu.log("#{action(__callee__)} positional (#{model}): " \
                "'#{attributes[:name]}'")

      model.new(attributes).store
    end
    alias_method :update, :add

    # Make the cursor of this (or named) interface invisible.
    #
    # @param name [String] Hide the cursor for the interface with this name.
    # @return [Cursor]
    def hide(name = Focus.current)
      find_or_create(name).hide
    end

    # Make the cursor of this (or named) interface visible.
    #
    # @param name [String] Show the cursor for the interface with this name.
    # @return [Cursor]
    def show(name = Focus.current)
      find_or_create(name).show
    end

    private

    # @return [Class] The model class for this repository.
    def model
      Vedeu::Cursor
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
