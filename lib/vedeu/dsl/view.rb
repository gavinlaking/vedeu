module Vedeu

  module DSL

    # DSL for creating views.
    #
    class View

      class << self

        # Register an interface by name which will display output from a event
        # or command. This provides the means for you to define your the views
        # of your application without their content.
        #
        #   Vedeu.interface 'my_interface' do
        #     # ... some code
        #   end
        #
        #   Vedeu.interface do
        #     name 'interfaces_must_have_a_name'
        #     # ... some code
        #   end
        #
        # @param name [String] The name of the interface. Used to reference the
        #   interface throughout your application's execution lifetime.
        # @param block [Proc] A set of attributes which define the features of
        #   the interface.
        # @raise [Vedeu::InvalidSyntax] The required block was not given.
        # @return [Vedeu::Interface]
        # @todo More documentation required.
        def interface(name = '', &block)
          fail Vedeu::InvalidSyntax, 'block not given' unless block_given?

          attributes = { client: client(&block), name: name }

          Vedeu::Interface.build(attributes, &block).store
        end

        # Directly write a view buffer to the terminal. Using this method means
        # that the refresh event does not need to be triggered after creating
        # the views, though can be later triggered if needed.
        #
        #   Vedeu.renders do
        #     view 'my_interface' do
        #       # ... some code
        #     end
        #   end
        #
        #   # or...
        #
        #   Vedeu.render do
        #     view 'my_interface' do
        #       # ... some code
        #     end
        #   end
        #
        # @param block [Proc] The directives you wish to send to render.
        #   Typically includes `view` with associated sub-directives.
        # @raise [Vedeu::InvalidSyntax] The required block was not given.
        # @return [Array<Interface>]
        def render(&block)
          fail Vedeu::InvalidSyntax, 'block not given' unless block_given?

          store(:store_immediate, &block)
        end
        alias_method :renders, :render

        # Define a view (content) for an interface.
        #
        # The views declared within this block are stored in their respective
        # interface back buffers until a refresh event occurs. When the refresh
        # event is triggered, the back buffers are swapped into the front
        # buffers and the content here will be rendered to
        # {Vedeu::Terminal.output}.
        #
        #   Vedeu.views do
        #     view 'my_interface' do
        #       # ... some attributes ...
        #     end
        #     view 'my_other_interface' do
        #       # ... some other attributes ...
        #     end
        #     # ... some code
        #   end
        #
        # @param block [Proc] The directives you wish to send to render.
        #   Typically includes `view` with associated sub-directives.
        # @raise [Vedeu::InvalidSyntax] The required block was not given.
        # @return [Array<Interface>]
        def view(&block)
          fail Vedeu::InvalidSyntax, 'block not given' unless block_given?

          store(:store_deferred, &block)
        end
        alias_method :views, :view

        private

        # Returns the client object which called the DSL method.
        #
        # @param block [Proc]
        # @return [Object]
        def client(&block)
          eval('self', block.binding)
        end

        # Creates a new Composition which may contain one or more views
        # (Interface objects).
        #
        # @param client [Object]
        # @param block [Proc]
        # @return [Vedeu::Composition]
        def composition(client, &block)
          Vedeu::Composition.build({ client: client }, &block)
        end

        # Stores each of the views defined in their respective buffers ready to
        # be rendered on next refresh.
        #
        # @param method [Symbol] An instruction; `:store_immediate` or
        #   `:store_deferred` which determines whether the view will be shown
        #   immediately or later respectively.
        # @param block [Proc]
        # @return [Array]
        def store(method, &block)
          composition(client(&block), &block).interfaces.map do |interface|
            interface.public_send(method)
          end
        end

      end # Eigenclass

    end # View

  end # DSL

end # Vedeu
