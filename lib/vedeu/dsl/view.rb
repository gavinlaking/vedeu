module Vedeu

  module DSL

    # There are two ways to construct views with Vedeu. You would like
    # to draw the view to the screen immediately (immediate render) or
    # you want to save a view to be drawn when you trigger a refresh
    # event later (deferred view).
    #
    # Both of these approaches require that you have defined an
    # interface (or 'visible area') first. You can find out how to
    # define an interface with Vedeu below or in
    # {Vedeu::Interfaces::DSL}. The examples in 'Immediate Render' and
    # 'Deferred View' use these interface definitions: (Note: should
    # you use these examples, ensure your terminal is at least 70
    # characters in width and 5 lines in height.)
    #
    #   Vedeu.interface :main do
    #     geometry do
    #       height 4
    #       width  50
    #     end
    #   end
    #
    #   Vedeu.interface :title do
    #     geometry do
    #       height 1
    #       width  50
    #       x      use('main').left
    #       y      use('main').north
    #     end
    #   end
    #
    # Both of these approaches use a concept of Buffers in Vedeu.
    # There are three buffers for any defined interface. These are
    # imaginatively called: 'back', 'front' and 'previous'.
    #
    # The 'back' buffer is the content for an interface which will be
    # shown next time a refresh event is fired globally or for that
    # interface. So, 'back' becomes 'front'.
    #
    # The 'front' buffer is the content for an interface which is
    # currently showing. When a refresh event is fired, again,
    # globally or for that interface specifically, the content of this
    # 'front' buffer is first copied to the 'previous' buffer, and
    # then the current 'back' buffer overwrites this 'front' buffer.
    #
    # The 'previous' buffer contains what was shown on the 'front'
    # before the current 'front'.
    #
    # You can only write to either the 'front' (you want the content
    # to be drawn immediately (immediate render)) or the 'back' (you
    # would like the content to be drawn on the next refresh
    # (deferred view)).
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

      include Vedeu::DSL
      include Vedeu::Cursors::DSL
      include Vedeu::DSL::Border
      include Vedeu::DSL::Geometry
      include Vedeu::DSL::Presentation
      include Vedeu::DSL::Use
      include Vedeu::DSL::Elements

      class << self

        include Vedeu::Common

        # Directly write a view buffer to the terminal. Using this
        # method means that the refresh event does not need to be
        # triggered after creating the views, though can be later
        # triggered when needed.
        #
        #   Vedeu.renders do
        #     view :some_interface do
        #       line do
        #         stream do
        #           left 'Title goes here', width: 35
        #         end
        #         stream do
        #           right Time.now.strftime('%H:%m'), width: 7
        #         end
        #       end
        #     end
        #     view :other_interface do
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
        #     view :my_interface do
        #       # ... some code
        #     end
        #   end
        #
        # @param block [Proc] The directives you wish to send to
        #   render. Typically includes `view` with associated
        #   sub-directives.
        # @raise [Vedeu::Error::RequiresBlock]
        # @return [Array<View>]
        def renders(&block)
          fail Vedeu::Error::RequiresBlock unless block_given?

          store(:store_immediate, client(&block), &block)
        end
        alias_method :render, :renders

        # Define a view (content) for an interface.
        #
        # As you can see by comparing the examples above to these
        # below, the immediate render simply wraps what is already
        # here in the deferred view.
        #
        # The views declared within this block are stored in their
        # respective interface back buffers until a refresh event
        # occurs. When the refresh event is triggered, the back
        # buffers are swapped into the front buffers and the content
        # here will be rendered to {Vedeu::Terminal#output}.
        #
        #   Vedeu.views do
        #     view :some_interface do
        #       line do
        #         stream do
        #           left 'Title goes here', width: 35
        #         end
        #         stream do
        #           right Time.now.strftime('%H:%m'), width: 7
        #         end
        #       end
        #     end
        #     view :other_interface do
        #       lines do
        #         line 'This is content for the main interface.'
        #         line ''
        #         line 'Pretty easy eh?'
        #       end
        #     end
        #     # ... some code
        #   end
        #
        # @param block [Proc] The directives you wish to send to
        #   render. Typically includes `view` with associated
        #   sub-directives.
        # @raise [Vedeu::Error::RequiresBlock]
        # @return [Array<View>]
        def views(&block)
          fail Vedeu::Error::RequiresBlock unless block_given?

          store(:store_deferred, client(&block), &block)
        end

        private

        # Returns the client object which called the DSL method.
        #
        # @param block [Proc]
        # @return [Object]
        def client(&block)
          eval('self', block.binding)
        end

        # Creates a new Vedeu::Views::Composition which may contain
        # one or more views (Vedeu::Views::View objects).
        #
        # @param client [Object]
        # @param block [Proc]
        # @return [Vedeu::Views::Composition]
        def composition(client, &block)
          attrs = { client: client, colour: Vedeu::Configuration.colour }

          Vedeu::Views::Composition.build(attrs, &block)
        end

        # Creates a new Vedeu::Views::Composition which may contain
        # one or more views (Vedeu::Views::View objects).
        #
        # Stores each of the views defined in their respective buffers
        # ready to be rendered on next refresh.
        #
        # @param method [Symbol] An instruction; `:store_immediate` or
        #   `:store_deferred` which determines whether the view will
        #   be shown immediately or later respectively.
        # @param client [Object] The client class which called the DSL
        #   object.
        # @param block [Proc]
        # @return [Array]
        def store(method, client, &block)
          composition(client, &block).views.map do |view|
            view.public_send(method)
          end
        end

      end # Eigenclass

    end # View

  end # DSL

  # @!method render
  #   @see Vedeu::DSL::View.render
  # @!method renders
  #   @see Vedeu::DSL::View.renders
  # @!method views
  #   @see Vedeu::DSL::View.views
  def_delegators Vedeu::DSL::View,
                 :renders,
                 :render,
                 :views

end # Vedeu
