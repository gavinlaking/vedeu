# frozen_string_literal: true

module Vedeu

  module Views

    # Provides view model methods for Vedeu::Views.
    #
    # @api private
    #
    module Value

      # @macro module_singleton_methods
      module SingletonMethods

        # @!attribute [w] collection_klass
        # @return [void]
        attr_reader :collection_klass

        # @!attribute [w] deputy_klass
        # @return [void]
        attr_reader :deputy_klass

        # @!attribute [w] entity_klass
        # @return [void]
        attr_reader :entity_klass

        # @!attribute [w] parent_klass
        # @return [void]
        attr_reader :parent_klass

        # @param model [void]
        # @return [void]
        def collection(model)
          @collection_klass = model
        end

        # @param model [void]
        # @return [void]
        def deputy(model)
          @deputy_klass = model
        end

        # @param model [void]
        # @return [void]
        def entity(model)
          @entity_klass = model
        end

        # @param model [void]
        # @return [void]
        def parent(model)
          @parent_klass = model
        end

      end # SingletonMethods

      # @macro module_instance_methods
      module InstanceMethods

        include Vedeu::Common

        # The client binding represents the client application object
        # that is currently invoking a DSL method. It is required so
        # that we can send messages to the client application object
        # should we need to.
        #
        # @!attribute [rw] client
        # @return [void]
        attr_accessor :client

        # @!attribute [rw] parent
        # @return [void]
        attr_accessor :parent

        # Adds the child to the collection.
        #
        # @param child [Vedeu::Views]
        # @return [Vedeu::Views]
        def add(child)
          @value = value.add(child)
        end
        alias << add

        # @return [Boolean]
        def client?
          present?(client)
        end

        # @return [void]
        def collection
          self.class.collection_klass
        end

        # Returns a DSL instance responsible for defining the DSL
        # methods of this model.
        #
        # @return [void]
        def deputy
          self.class.deputy_klass.new(self, client)
        end

        # @return [void]
        def entity
          self.class.entity_klass
        end

        # @return [void]
        def value
          collection.coerce(@value || [], self)
        end

        # @param value [void]
        # @return [void]
        def value=(value)
          @value = collection.coerce(value, self)
        end

        # Returns a boolean indicating whether this model has a
        # non-empty value.
        #
        # @return [Boolean]
        def value?
          value.any?
        end

      end # InstanceMethods

      # @macro module_included
      def self.included(klass)
        klass.extend(Vedeu::Views::Value::SingletonMethods)
        klass.include(Vedeu::Views::Value::InstanceMethods)
      end

    end # Value

  end # Views

end # Vedeu
