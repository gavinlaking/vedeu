module Vedeu

  module Repositories

    # When included into a class, provides the mechanism to store the
    # class in a repository for later retrieval.
    #
    module Model

      # This is used by including classes.
      include Vedeu::Common

      # @!attribute [rw] repository
      # @return [Vedeu::Repositories::Repository]
      attr_accessor :repository

      # When {Vedeu::Repositories::Model} is included in a class, the
      # methods within this module are included as class methods on
      # that class.
      #
      module ClassMethods

        # @!attribute [r] repository
        # @return [Vedeu::Repositories::Repository]
        attr_reader :repository

        # Build models using a simple DSL when a block is given,
        # otherwise returns a new instance of the class including this
        # module.
        #
        # @param attributes [Hash] A collection of attributes specific
        #   to the model.
        # @param block [Proc] The block passed to the build method.
        # @return [Object] An instance of the model.
        def build(attributes = {}, &block)
          attributes = defaults.merge!(attributes)

          model = new(attributes)

          if block_given?
            model.deputy(attributes[:client]).instance_eval(&block)
          end

          model
        end

        # Provide a convenient way to define the child or children of
        # a model.
        #
        # @param klass [Class] The member (singular) or collection
        #   (multiple) class name for the respective model.
        # @return [void]
        def child(klass)
          send(:define_method, __callee__) { klass }
        end
        alias_method :member,     :child
        alias_method :collection, :child

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
        # @param block [Proc] A block of code to be executing whilst
        #   storing.
        # @return [Object] An instance of the model.
        def store(attributes = {}, &block)
          if block_given?
            new(attributes).store(&block)

          else
            new(attributes).store

          end
        end

        private

        # The default values for a new instance of this class.
        #
        # @return [Hash<Symbol => NilClass, String>]
        def defaults
          {
            client: nil,
            name:   '',
          }
        end

      end # ClassMethods

      # When this module is included in a class, provide ClassMethods
      # as class methods for the class.
      #
      # @param klass [Class]
      # @return [void]
      def self.included(klass)
        klass.send(:extend, ClassMethods)
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
