# frozen_string_literal: true

module Vedeu

  module Repositories

    # When included into a class, provides the mechanism to store the
    # class in a repository for later retrieval.
    #
    module Model

      # @!attribute [rw] repository
      # @return [Vedeu::Repositories::Repository]
      attr_accessor :repository

      # @macro module_singleton_methods
      module SingletonMethods

        # @!attribute [r] repository
        # @return [Vedeu::Repositories::Repository]
        attr_reader :repository

        # Build models using a simple DSL when a block is given,
        # otherwise returns a new instance of the class including this
        # module.
        #
        # @param attributes [Hash] A collection of attributes specific
        #   to the model.
        # @macro param_block
        # @return [Object] An instance of the model.
        def build(attributes = {}, &block)
          model = new(attributes)

          Vedeu.log(type:    :debug,
                    message: "DSL building: '#{model.class.name}' for " \
                             "'#{model.name}'")

          model.deputy.instance_eval(&block) if block_given?

          model
        end

        # Allow models to specify their repository using a class
        # method.
        #
        # @param klass [void]
        # @return [void]
        def repo(klass)
          @repository = klass
        end

        # Create and store a model with the given attributes.
        #
        # @param attributes [Hash] A collection of attributes specific
        #   to the model.
        # @macro param_block
        # @return [Object] An instance of the model.
        def store(attributes = {}, &block)
          new(attributes).store(&block)
        end

      end # SingletonMethods

      # @macro module_included
      def self.included(klass)
        klass.extend(Vedeu::Repositories::Model::SingletonMethods)
      end

      # @note If a block is given, store the model, return the model
      #   after yielding.
      # @todo Perhaps some validation could be added here?
      # @return [void] The model instance stored in the repository.
      def store(&block)
        repository.store(self, &block)
      end

    end # Model

  end # Repositories

end # Vedeu
