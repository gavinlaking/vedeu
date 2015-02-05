require 'vedeu/dsl/shared/all'

module Vedeu

  module DSL

    class ModelTestClass

      include Vedeu::DSL::Colour
      include Vedeu::DSL::Style

      def initialize(model, client_binding = nil)
        @model = model
        @client_binding = client_binding
      end

      private

      attr_reader :model

    end # ModelTestClass

  end # DSL

end # Vedeu
