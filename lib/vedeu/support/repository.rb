require 'vedeu/exceptions'
require 'vedeu/models/all'
require 'vedeu/support/common'

module Vedeu

  # Provides common methods for accessing the various repositories Vedeu uses.
  #
  # @example
  #   { 'models' => [Model, Model, Model] }
  #
  #   { 'models' => [Model] }
  #
  # @api private
  class Repository

    include Vedeu::Common

    attr_reader :model, :storage

    def initialize(model = nil, storage = {})
      @model   = model
      @storage = storage
    end

    # Return the whole repository.
    #
    # @return [Array|Hash|Set]
    def all
      storage
    end

    # Return the model for the interface currently in focus.
    #
    # @return []
    def current
      find_or_create(Focus.current)
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
    # @raise [ModelNotFound] When the model cannot be found with this name.
    # @return [Hash]
    def find(name)
      storage.fetch(name) do
        fail ModelNotFound, "Cannot find model by name: '#{name}'"
      end
    end

    # Find a model by name, registers the model by name if not found.
    #
    # @param name [String]
    # @return []
    def find_or_create(name)
      if registered?(name)
        find(name)

      else
        Vedeu.log("Model (#{model}) not found, registering: '#{name}'")

        model.new(name).store
      end
    end
    alias_method :by_name, :find_or_create

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
      @storage = in_memory
    end

    # Stores the model instance by name in the repository of the model.
    #
    # @param model [void] A model instance.
    # @return [void] The model instance which was stored.
    def store(model)
      fail MissingRequired, "Cannot store model '#{model.class}' without a " \
                            "name attribute." unless defined_value?(model.name)

      storage[model.name] = model
    end
    alias_method :register, :store

    # Access a model by name.
    #
    # @param name [String]
    # @return []
    def use(name)
      if registered?(name)
        find(name)

      else
        nil

      end
    end

    private

    def in_memory
      {}
    end

  end # Repository

  class Groups < Repository
  end

  class Interfaces < Repository
  end

  class Menus < Repository
  end

end # Vedeu
