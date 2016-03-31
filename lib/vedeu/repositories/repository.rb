# frozen_string_literal: true

module Vedeu

  module Repositories

    # Provides common methods for accessing the various repositories
    # Vedeu uses.
    #
    # @example
    #   { 'models' => [Model, Model, Model] }
    #
    #   { 'models' => [Model] }
    #
    # @api private
    #
    class Repository

      include Vedeu::Common
      include Vedeu::Repositories::Registerable
      include Vedeu::Repositories::Store

      # @!attribute [r] model
      # @return [void]
      attr_reader :model

      # @!attribute [r] storage
      # @return [void]
      attr_reader :storage

      # Returns a new instance of Vedeu::Repositories::Repository.
      #
      # @param model [Class]
      # @param storage [Class|Hash]
      # @return [Vedeu::Repositories::Repository]
      def initialize(model = nil, storage = {})
        @model   = model
        @storage = storage
      end

      # Returns the repository class.
      #
      # @return [Class]
      def repository
        self.class
      end

      # Return all the registered models.
      #
      # @return [Array<void>] An array containing each stored model.
      def all
        return storage.values if hash?(storage)

        registered
      end

      # Return the named model or a null object if not registered.
      #
      # @example
      #   # Fetch the cursor belonging to the interface of the same
      #   # name.
      #   Vedeu.cursors.by_name(:some_name)
      #
      #   # Fetch the names of the interfaces belonging to this group.
      #   Vedeu.groups.by_name(name)
      #
      # @macro param_name
      # @return [void]
      def by_name(name = nil)
        name = present?(name) ? name : Vedeu.focus

        return find(name) if registered?(name)

        null_model.new(null_attributes.merge(name: name)) if null_model?
      end

      # Return the model for the interface currently in focus.
      #
      # @return [String|NilClass]
      def current
        find_or_create(Vedeu.focus) if Vedeu.focus
      end

      # Find the model by name.
      #
      # @macro param_name
      # @return [Hash<String => Object>|NilClass]
      def find(name)
        storage[name]
      end

      # Find the model attributes by name, raises an exception when
      # the model cannot be found.
      #
      # @macro param_name
      # @raise [Vedeu::Error::ModelNotFound] When the model cannot be
      #   found with this name.
      # @return [Hash<String => Object>]
      def find!(name)
        find(name) || raise(Vedeu::Error::ModelNotFound,
                            "Cannot find model by name: '#{name}'")
      end

      # Find a model by name, registers the model by name when not
      # found.
      #
      # @macro param_name
      # @return [void]
      def find_or_create(name)
        return find(name) if registered?(name)

        Vedeu.log(type:    :store,
                  message: "Model (#{model}) not found, " \
                           "registering: '#{name}'")

        model.new(name).store
      end

      # @return [String]
      def inspect
        "<#{self.class.name}>"
      end

      # Returns a boolean indicating whether the named model is
      # registered.
      #
      # @macro param_name
      # @return [Boolean]
      def registered?(name)
        return false if absent?(name)
        return false if empty?

        storage.include?(name)
      end

      # Returns the storage with the named model removed, or false
      # when the model does not exist.
      #
      # @macro param_name
      # @return [Hash|Boolean]
      def remove(name)
        return false if empty?
        return false unless registered?(name)

        storage.delete(name)
        storage unless storage.is_a?(Set)
      end
      alias delete remove

      # Stores the model instance by name in the repository of the
      # model.
      #
      # @note If a block is given, store the model, return the model
      #   after yielding.
      # @param model [void] A model instance.
      # @macro raise_missing_required
      # @return [void] The model instance which was stored.
      def store(model, &block)
        valid_model?(model)

        log_store(model)

        storage[model.name] = model

        yield if block_given?

        model
      end
      alias register store
      alias add store

      private

      # @param model [void] A model instance.
      # @return [String]
      def log_store(model)
        type = registered?(model.name) ? :update : :create

        Vedeu.log(type:    type,
                  message: "#{model.class.name}: '#{model.name}'")
      end

      # @param model [void] A model instance.
      # @macro raise_missing_required
      # @return [Boolean]
      def valid_model?(model)
        raise Vedeu::Error::MissingRequired,
              "Cannot store model '#{model.class}' without a name " \
              'attribute.' unless present?(model.name)
      end

    end # Repository

  end # Repositories

end # Vedeu
