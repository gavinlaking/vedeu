module Vedeu

  module DSL

    # DSL for creating collections of interfaces.
    #
    class Composition

      # Returns an instance of DSL::Composition.
      #
      # @param model [Composition]
      def initialize(model, client_binding = nil)
        @model = model
        @client_binding = client_binding
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
      # @raise [InvalidSyntax] The required block was not given.
      # @return [Vedeu::Model::Collection<Vedeu::Interface>]
      def view(name = '', &block)
        unless block_given?
          fail InvalidSyntax, "'#{__callee__}' requires a block."
        end

        view = Vedeu::Interface.build({ name: name, parent: model }, &block)

        model.interfaces.add(view)
      end

      private

      attr_reader :model

      # @param method [Symbol] The name of the method sought.
      # @param args [Array] The arguments which the method was to be invoked
      #   with.
      # @param block [Proc] The optional block provided to the method.
      # @return []
      def method_missing(method, *args, &block)
        Vedeu.log("!!!method_missing '#{method}' (args: #{args.inspect})")

        @client_binding.send(method, *args, &block) if @client_binding
      end

    end # Composition

  end # DSL

end # Vedeu
