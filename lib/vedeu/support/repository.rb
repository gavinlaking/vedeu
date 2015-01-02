require 'vedeu/support/common'

module Vedeu

  # Provides common methods for accessing the various repositories Vedeu uses.
  #
  # @api private
  module Repository

    include Vedeu::Common

    # Return the whole repository.
    #
    # @return [Array|Hash|Set]
    def all
      storage
    end

    # Return a boolean indicating whether the storage is empty.
    #
    # @return [Boolean]
    def empty?
      storage.empty?
    end

    # Find the model attributes by name.
    #
    # @param name [String]
    # @return [Hash]
    def find(name)
      storage.fetch(name) { not_found(name) }
    end

    # Find a model by name, registers the model by name if not found.
    #
    # @param name [String]
    # @param attributes [Hash]
    # @return [Cursor|Offset]
    def find_or_create(name, attributes = {})
      storage.fetch(name) do
        Vedeu.log("Model (#{model}) not found, registering: '#{name}'")

        model.new({ name: name }.merge(attributes)).store
      end
    end

    # Returns a collection of the names of all the registered entities.
    #
    # @return [Array]
    def registered
      return [] if empty?

      return storage.keys if storage.is_a?(Hash)
      return storage.to_a if storage.is_a?(Set)

      storage
    end

    # Returns a boolean indicating whether the named model is registered.
    #
    # @param name [String]
    # @return [Boolean]
    def registered?(name)
      return false if empty?

      storage.include?(name)
    end

    # Returns the storage with the named model removed, or false if the model
    # does not exist.
    #
    # @param name [String]
    # @return [Hash|FalseClass]
    def remove(name)
      return false if empty?

      if registered?(name)
        storage.delete(name)
        storage unless storage.is_a?(Set)

      else
        false

      end
    end
    alias_method :destroy, :remove
    alias_method :delete,  :remove

    # Reset the repository.
    #
    # @return [Array|Hash|Set]
    def reset
      @_storage = in_memory
    end

    # Stores the model instance by name in the repository of the model.
    #
    # @param model [void] A model instance.
    # @return [void] The model instance which was stored.
    def store(model)
      fail MissingRequired, "Cannot store model '#{model.class}' without a " \
                            "name attribute." unless defined_value?(model.name)

      Vedeu.log("Registering #{model.class.to_s}: #{model.name}")

      storage[model.name] = model
    end

    private

    # @param method [Symbol]
    # @return [String]
    def action(method)
      return 'Registering' if method == :add

      'Updating'
    end

    # @param name [String]
    # @raise [ModelNotFound] When the model cannot be found with this name.
    # @return [ModelNotFound]
    def not_found(name)
      fail ModelNotFound, "Cannot find model by name: '#{name}'"
    end

    # Access to the storage for this repository.
    #
    # @return [Hash]
    def storage
      @_storage ||= in_memory
    end

    # Raises the MissingRequired exception.
    #
    # @param attr [String] A textual representation of the attribute.
    # @raise [MissingRequired] When an attribute, defined by the attr parameter
    #   is missing.
    # @return [MissingRequired]
    def missing_required(attr = 'name')
      fail MissingRequired, "Cannot store data without a #{attr} attribute."
    end

  end # Repository

end # Vedeu
