require 'vedeu/support/common'

module Vedeu

  module DSL

    class Composition

      include Vedeu::Common

      # Returns an instance of DSL::Composition.
      #
      # @param model [Composition]
      def initialize(model)
        @model = model
      end

      # Define a view.
      #
      # A view is just an Interface object.
      #
      # @todo More documentation required.
      # @param name [String] The name of the interface you are targetting for
      #   this view.
      # @param block [Proc] The directives you wish to send to this interface.
      #
      # @example
      #   view 'my_interface' do
      #     ...
      #
      # @return [Hash]
      def view(name = '', &block)
        return requires_block(__callee__) unless block_given?

        new_interface      = Vedeu::Interface.build(nil, model, nil, nil, &block)
        new_interface.name = name if defined_value?(name)

        model.interfaces.add(new_interface)
      end

      private

      attr_reader :model

    end # Composition

  end # DSL

end # Vedeu
