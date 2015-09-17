module Vedeu

  module Repositories

    module DSL

      class ModelTestClass

        include Vedeu::DSL::Presentation

        def initialize(model, client = nil)
          @model  = model
          @client = client
        end

        protected

        attr_reader :model

      end # DSL

    end # ModelTestClass

    module RepositoryTestModule

      extend self

      def by_name(name)
        model
      end

      # The real repository stores the model and returns it.
      def store(model)
        model
      end

      private

      # A storage solution that uses memory to persist models.
      def in_memory
        {}
      end

    end # RepositoryTestModule

    class ModelTestClass

      include Vedeu::Repositories::Model
      include Vedeu::Presentation

      attr_accessor :background, :colour, :name, :style

      def initialize(attributes = {})
        @attributes = defaults.merge!(attributes)

        @attributes.each { |key, value| instance_variable_set("@#{key}", value) }
      end

      private

      # Returns the default options/attributes for this class.
      #
      def defaults
        {
          colour:     {},
          name:       '',
          repository: Vedeu::Repositories::RepositoryTestModule,
          style:      [],
        }
      end

    end # ModelTestClass

  end # Repositories

end # Vedeu
