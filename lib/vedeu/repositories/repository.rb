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
  class Repository

    include Vedeu::Common
    include Enumerable

    # @!attribute [r] model
    # @return [void]
    attr_reader :model

    # @!attribute [r] storage
    # @return [void]
    attr_reader :storage

    # Returns a new instance of Vedeu::Repository.
    #
    # @param model [Class]
    # @param storage [Class|Hash]
    # @return [Vedeu::Repository]
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
    # @return [String|NilClass]
    def current
      find_or_create(Vedeu.focus) if Vedeu.focus
    end

    # @return [Enumerator]
    def each(&block)
      storage.each(&block)
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
    # @return [Hash<String => Object>]
    def find(name)
      storage.fetch(name) do
        fail ModelNotFound, "Cannot find model by name: '#{name}'"
      end
    end

    # Find a model by name, registers the model by name if not found.
    #
    # @param name [String]
    # @return [void]
    def find_or_create(name)
      if registered?(name)
        find(name)

      else
        Vedeu.log(type: :store, message: "Model (#{model}) not found, registering: '#{name}'")

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
      return false if name.nil? || name.empty?
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
    alias_method :destroy,    :remove
    alias_method :delete,     :remove
    alias_method :deregister, :remove

    # Reset the repository.
    #
    # @return [Array|Hash|Set]
    def reset
      @storage = in_memory
    end

    # Stores the model instance by name in the repository of the model.
    #
    # @param model [void] A model instance.
    # @raise [MissingRequired] When the name attribute is not defined.
    # @return [void] The model instance which was stored.
    def store(model)
      fail MissingRequired, "Cannot store model '#{model.class}' without a " \
                            "name attribute." unless defined_value?(model.name)

      Vedeu.log(type: log_type(model), message: "#{model.class.name}: '#{model.name}'")

      storage[model.name] = model
    end
    alias_method :register, :store

    # Access a model by name.
    #
    # @param name [String]
    # @return [|NilClass]
    def use(name)
      if registered?(name)
        find(name)

      else
        nil

      end
    end

    private

    # @return [Hash]
    def in_memory
      {}
    end

    # @return [String]
    def log_type(model)
      if registered?(model.name)
        :update

      else
        :create

      end
    end

  end # Repository

end # Vedeu
