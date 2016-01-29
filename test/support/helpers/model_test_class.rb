# frozen_string_literal: true

module Vedeu

  module Repositories

    module DSL

      class ModelTestClass

        include Vedeu::DSL
        include Vedeu::DSL::Presentation

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
        defaults.merge!(attributes).each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      private

      # @macro defaults_method
      def defaults
        {
          client:     nil,
          colour:     {},
          name:       '',
          repository: Vedeu::Repositories::RepositoryTestModule,
          style:      [],
        }
      end

    end # ModelTestClass

  end # Repositories

end # Vedeu
