# frozen_string_literal: true

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
    class Views

      include Vedeu::DSL
      include Vedeu::DSL::Cursors
      include Vedeu::DSL::Border
      include Vedeu::DSL::Geometry
      include Vedeu::DSL::Use
      include Vedeu::DSL::Elements

      class << self

        # {include:file:docs/dsl/by_method/renders.md}
        # @macro param_block
        # @macro raise_requires_block
        # @return [Vedeu::Views::Composition]
        def renders(&block)
          raise Vedeu::Error::RequiresBlock unless block_given?

          composition(true, &block)
        end
        alias render renders

        # {include:file:docs/dsl/by_method/views.md}
        # @macro param_block
        # @macro raise_requires_block
        # @return [Vedeu::Views::Composition]
        def views(&block)
          raise Vedeu::Error::RequiresBlock unless block_given?

          composition(false, &block)
        end

        private

        # Handles the directives you wish to send to render. Typically
        # includes `view` with associated sub-directives. The binding
        # of the block is also accessed so that we can ascertain the
        # calling client application class, this is so that if there
        # methods being called inside your views, Vedeu will redirect
        # that call to the client class instance instead. (This
        # actually occurs when Vedeu rescues from method_missing. See
        # {Vedeu::DSL}.)
        #
        # @macro param_block
        # @return [void]
        def client_binding(&block)
          eval('self', block.binding).tap do |client|
            Vedeu.log(type:    :debug,
                      message: "Client binding: #{client.class.name}")
          end
        end

        # Creates a new Vedeu::Views::Composition which may contain
        # one or more view {Vedeu::Views::View} objects.
        #
        # @param refresh [Boolean]
        # @macro param_block
        # @return [Vedeu::Views::Composition]
        def composition(refresh = false, &block)
          attrs = {
            client: client_binding(&block),
            colour: Vedeu.config.colour,
          }

          Vedeu::Views::Composition.build(attrs, &block).update_buffers(refresh)
        end

      end # Eigenclass

    end # Views

  end # DSL

  # @api public
  # @!method render
  #   @see Vedeu::DSL::Views.render
  # @api public
  # @!method renders
  #   @see Vedeu::DSL::Views.renders
  # @api public
  # @!method views
  #   @see Vedeu::DSL::Views.views
  def_delegators Vedeu::DSL::Views,
                 :renders,
                 :render,
                 :views

end # Vedeu
