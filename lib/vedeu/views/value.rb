module Vedeu

  module Views

    module Value

      module ClassMethods

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

      end # ClassMethods

      module InstanceMethods

        include Vedeu::Common

        # The client binding represents the client application object
        # that is currently invoking a DSL method. It is required so
        # that we can send messages to the client application object
        # should we need to.
        #
        # @return [void]
        def client
          @_client ||= client? ? @client : nil
        end

        # @return [Boolean]
        def client?
          present?(@client)
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

        # @return [NilClass|void]
        def parent
          @_parent ||= parent? ? @parent : nil
        end

        # @return [Boolean]
        def parent?
          present?(@parent)
        end

        # @return [void]
        def value
          @_value ||= if present?(@value)
                        collection.coerce(@value, self)

                      else
                        collection.coerce([], self)

                      end
        end

        # @param value [void]
        # @return [void]
        def value=(value)
          @_value = @value = collection.coerce(value, self)
        end

        # Returns a boolean indicating whether this model has a
        # non-empty value.
        #
        # @return [Boolean]
        def value?
          value.any?
        end

      end # InstanceMethods

      # When this module is included in a class, provide ClassMethods
      # as class methods and InstanceMethods as instance methods for
      # the given class.
      #
      # @param klass [Class]
      # @return [void]
      def self.included(klass)
        klass.extend(Vedeu::Views::Value::ClassMethods)
        klass.include(Vedeu::Views::Value::InstanceMethods)
      end

    end # Value

  end # Views

end # Vedeu