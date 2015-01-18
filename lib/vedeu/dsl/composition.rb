require 'vedeu/support/common'

module Vedeu

  module DSL

    # DSL for creating collections of interfaces.
    #
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
      # @param interface_name [String] The name of the interface you are
      #   targetting for this view.
      # @param block [Proc] The directives you wish to send to this interface.
      #
      # @example
      #   view 'my_interface' do
      #     ...
      #
      # @raise [InvalidSyntax] The required block was not given.
      # @return [Vedeu::Model::Collection<Vedeu::Interface>]
      def view(interface_name = '', &block)
        fail InvalidSyntax, "'#{__callee__}' requires a block." unless block_given?

        interface = Vedeu::Interface.build(nil, model, nil, nil) do
          name interface_name
        end

        model.interfaces.add(interface)
      end

      private

      attr_reader :model

    end # Composition

  end # DSL

end # Vedeu
