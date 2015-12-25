# frozen_string_literal: true

module Vedeu

  module Repositories

    # Repositories contain registerables, this module provides
    # convenience methods for them.
    #
    module Registerable

      # These class methods are mixed into the repository.
      module ClassMethods

        # The null model is used when the repository cannot be found.
        #
        # @param klass [Class]
        # @param attributes [Hash]
        # @return [Symbol]
        def null(klass, attributes = {})
          define_method(:null_model)      { klass }
          define_method(:null_attributes) { attributes || {} }
        end

        # The real model is the usual model to use for a given
        # repository.
        #
        # @param klass [Class]
        # @return [Symbol]
        def real(klass)
          define_method(:model) { instance_variable_set('@model', klass) }
        end

        # Register a repository for storing models.
        #
        # @param model [Class]
        # @param storage [Class|Hash]
        # @return [Vedeu::Repositories::Repository]
        def register(model = nil, storage = {})
          new(model, storage).tap do |klass|
            Vedeu::Repositories.register(klass.repository)
          end
        end

        # Returns the repositories registered.
        #
        # @note
        #   If the repository is 'Geometries', for example, then
        #   @models will be either an empty Geometries repository or
        #   the collection of stored models.
        #
        # @return [void]
        def repository
          @models ||= reset!
        end

        # Remove all stored models from the repository.
        #
        # @return [void]
        def reset!
          @models = register
        end
        alias_method :reset, :reset!

      end # ClassMethods

      # When {Vedeu::Repositories::Registerable} is included in a
      # class, the methods within this module are included as instance
      # methods on that class.
      #
      module InstanceMethods

        # @return [Boolean]
        def null_model?
          self.respond_to?(:null_model) && present?(:null_model)
        end

      end # InstanceMethods

      # When this module is included in a class, provide ClassMethods
      # as class methods for the class.
      #
      # @param klass [Class]
      # @return [void]
      def self.included(klass)
        klass.extend(Vedeu::Repositories::Registerable::ClassMethods)
        klass.include(Vedeu::Repositories::Registerable::InstanceMethods)
      end

    end # Registerable

  end # Repositories

end # Vedeu
