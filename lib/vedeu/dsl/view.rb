module Vedeu

  module DSL

    # There are two ways to construct views with Vedeu. You would like to draw
    # the view to the screen immediately (immediate render) or you want to save
    # a view to be drawn when you trigger a refresh event later (deferred view).
    #
    # Both of these approaches require that you have defined an interface (or
    # 'visible area') first. You can find out how to define an interface with
    # Vedeu here. The examples in 'Immediate Render' and 'Deferred View' use
    # these interface definitions: (Note: if you use these examples, ensure your
    # terminal is at least 70 characters in width and 5 lines in height.)
    #
    #   Vedeu.interface 'main' do
    #     geometry do
    #       centred!
    #       height 4
    #       width  50
    #     end
    #   end
    #
    #   Vedeu.interface 'title' do
    #     geometry do
    #       height 1
    #       width  50
    #       x      use('main').left
    #       y      use('main').north
    #     end
    #   end
    #
    # Both of these approaches use a concept of Buffers in Vedeu. There are
    # three buffers for any defined interface. These are imaginatively called:
    # 'back', 'front' and 'previous'.
    #
    # The 'back' buffer is the content for an interface which will be shown next
    # time a refresh event is fired globally or for that interface. So, 'back'
    # becomes 'front'.
    #
    # The 'front' buffer is the content for an interface which is currently
    # showing. When a refresh event is fired, again, globally or for that
    # interface specifically, the content of this 'front' buffer is first copied
    # to the 'previous' buffer, and then the current 'back' buffer overwrites
    # this 'front' buffer.
    #
    # The 'previous' buffer contains what was shown on the 'front' before the
    # current 'front'.
    #
    # You can only write to either the 'front' (you want the content to be drawn
    # immediately (immediate render)) or the 'back' (you would like the content
    # to be drawn on the next refresh (deferred view)).
    #
    # The basic view DSL methods look like this:
    #
    #   renders/views
    #     |- view
    #         |- lines
    #         |   |- line
    #         |       |- streams
    #         |       |   |- stream
    #         |       |       |- char
    #         |       |
    #         |       |- stream
    #         |           |- char
    #         |
    #         |- line
    #             |- streams
    #             |   |- stream
    #             |       |- char
    #             |
    #             |- stream
    #                 |- char
    #
    #   renders/views
    #     |- view
    #         |- lines/line
    #             |- streams/stream
    #                 |- char
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
        #     view 'some_interface' do
        #       line do
        #         stream do
        #           left 'Title goes here', width: 35
        #         end
        #         stream do
        #           right Time.now.strftime('%H:%m'), width: 7
        #         end
        #       end
        #     end
        #     view 'other_interface' do
        #       lines do
        #         line 'This is content for the main interface.'
        #         line ''
        #         line 'Pretty easy eh?'
        #       end
        #     end
        #     # ... some code
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
        # As you can see by comparing the examples above to these below, the
        # immediate render simply wraps what is already here in the deferred
        # view.
        #
        # The views declared within this block are stored in their respective
        # interface back buffers until a refresh event occurs. When the refresh
        # event is triggered, the back buffers are swapped into the front
        # buffers and the content here will be rendered to
        # {Vedeu::Terminal.output}.
        #
        #   Vedeu.views do
        #     view 'some_interface' do
        #       line do
        #         stream do
        #           left 'Title goes here', width: 35
        #         end
        #         stream do
        #           right Time.now.strftime('%H:%m'), width: 7
        #         end
        #       end
        #     end
        #     view 'other_interface' do
        #       lines do
        #         line 'This is content for the main interface.'
        #         line ''
        #         line 'Pretty easy eh?'
        #       end
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
