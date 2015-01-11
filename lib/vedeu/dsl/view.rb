require 'vedeu/support/common'
require 'vedeu/models/view/composition'

module Vedeu

  module DSL

    # @api public
    class View

      class << self

        include Vedeu::Common

        # Register an interface by name which will display output from a event
        # or command. This provides the means for you to define your the views
        # of your application without their content.
        #
        # @todo More documentation required.
        #
        # @param interface_name [String] The name of the interface. Used to
        #   reference the interface throughout your application's execution
        #   lifetime.
        # @param block [Proc] A set of attributes which define the features of
        #   the interface.
        #
        # @example
        #   Vedeu.interface 'my_interface' do
        #     ...
        #
        #   Vedeu.interface do
        #     name 'interfaces_must_have_a_name'
        #     ...
        #
        # @raise [InvalidSyntax] When the required block is not given.
        # @return [Interface]
        def interface(interface_name = '', &block)
          return requires_block(__callee__) unless block_given?

          interface      = Vedeu::Interface.build(&block)
          interface.name = interface_name if defined_value?(interface_name)
          interface.store
        end

        # Immediate render
        #
        # Directly write a view buffer to the terminal. Using this method means
        # that the refresh event does not need to be triggered after creating
        # the views, though can be later triggered if needed.
        #
        # @param block [Proc] The directives you wish to send to render.
        #   Typically includes `view` with associated sub-directives.
        #
        # @example
        #   Vedeu.renders do
        #     view 'my_interface' do
        #       ...
        #
        # @raise [InvalidSyntax] When the required block is not given.
        # @return [Array<Interface>]
        def renders(&block)
          return requires_block(__callee__) unless block_given?

          store(:store_immediate, &block)
        end

        # Deferred view
        #
        # Define a view (content) for an interface.
        #
        # @note The views declared within this block are stored in their
        #   respective interface back buffers until a refresh event occurs. When
        #   the refresh event is triggered, the back buffers are swapped into the
        #   front buffers and the content here will be rendered to
        #   {Terminal.output}.
        #
        # @param block [Proc] The directives you wish to send to render. Typically
        #   includes `view` with associated sub-directives.
        #
        # @example
        #   Vedeu.views do
        #     view 'my_interface' do
        #       ... some attributes ...
        #     end
        #     view 'my_other_interface' do
        #       ... some other attributes ...
        #     end
        #     ...
        #
        # @raise [InvalidSyntax] When the required block is not given.
        # @return [Array<Interface>]
        def views(&block)
          return requires_block(__callee__) unless block_given?

          store(:store_deferred, &block)
        end

        private

        def composition(&block)
          Vedeu::Composition.build([], nil, nil, &block)
        end

        def store(method, &block)
          composition(&block).interfaces.map do |interface|
            interface.public_send(method)
          end
        end

      end

    end # View

  end # DSL

end # Vedeu
