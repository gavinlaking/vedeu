module Vedeu

  # Provides common methods for accessing the various repositories Vedeu uses.
  #
  # @api private
  module Repository

    include Common

    # Return the whole repository.
    #
    # @return [Array|Hash|Set]
    def all
      storage
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
    # @return [Cursor|Offset]
    def find_or_create(name)
      storage.fetch(name) do
        Vedeu.log("Model (#{model}) not found, registering: '#{name}'")

        model.new({ name: name }).store
      end
    end

    # Returns a collection of the names of all the registered entities.
    #
    # @return [Array]
    def registered
      return [] if storage.empty?

      return storage.keys if storage.is_a?(Hash)
      return storage.to_a if storage.is_a?(Set)

      storage
    end

    # Returns a boolean indicating whether the named model is registered.
    #
    # @param name [String]
    # @return [Boolean]
    def registered?(name)
      return false if storage.empty?

      storage.include?(name)
    end

    # Returns the storage with the named model removed, or false if the model
    # does not exist.
    #
    # @param name [String]
    # @return [Hash|FalseClass]
    def remove(name)
      return false if storage.empty?

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

    # At present, validates that attributes has a `:name` key that is not nil or
    # empty.
    #
    # @param attributes [Hash]
    # @return [TrueClass|MissingRequired]
    def validate_attributes!(attributes)
      return missing_required unless attributes.key?(:name)
      return missing_required unless defined_value?(attributes[:name])

      true
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
