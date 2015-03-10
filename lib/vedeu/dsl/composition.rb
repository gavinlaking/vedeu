require 'vedeu/models/view/interface'

module Vedeu

  module DSL

    # DSL for creating collections of interfaces.
    #
    class Composition

      include Vedeu::DSL

      # Returns an instance of DSL::Composition.
      #
      # @param model [Composition]
      # @param client [Object]
      # @return [Vedeu::DSL::Composition]
      def initialize(model, client = nil)
        @model  = model
        @client = client
      end

      # Define a view.
      #
      # A view is just an Interface object.
      #
      # When a view already exists, we take its attributes and use them as the
      # basis for the newly defined view. This way we don't need to specify
      # everything again.
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
      # @raise [InvalidSyntax] The required block was not given.
      # @return [Vedeu::Interfaces<Vedeu::Interface>]
      def view(name = '', &block)
        fail InvalidSyntax, 'block not given' unless block_given?

        new_model = model.member.build(new_attributes(name), &block)

        model.add(new_model)
      end

      private

      # @!attribute [r] client
      # @return [Object]
      attr_reader :client

      # @!attribute [r] model
      # @return [Composition]
      attr_reader :model

      # @param name [String] The name of the interface.
      # @return [Hash]
      def new_attributes(name)
        attributes.merge!(existing_interface_attributes(name))
      end

      # @param name [String] The name of the interface.
      # @return [Hash]
      def existing_interface_attributes(name)
        if model.repository.registered?(name)
          stored = model.repository.find(name)
          stored.attributes

        else
          { name: name }

        end
      end

      # @return [Hash]
      def attributes
        {
          client: client,
          parent: model,
        }
      end

    end # Composition

  end # DSL

end # Vedeu
