require 'vedeu/support/common'
require 'vedeu/models/view/composition'

module Vedeu

  module DSL

    # DSL for creating views.
    #
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
        # @param name [String] The name of the interface. Used to reference the
        #   interface throughout your application's execution lifetime.
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
        # @raise [InvalidSyntax] The required block was not given.
        # @return [Interface]
        def interface(name = '', &block)
          unless block_given?
            fail InvalidSyntax, "'#{__callee__}' requires a block."
          end

          Vedeu::Interface.build({ name: name }, &block).store
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
        # @raise [InvalidSyntax] The required block was not given.
        # @return [Array<Interface>]
        def renders(&block)
          unless block_given?
            fail InvalidSyntax, "'#{__callee__}' requires a block."
          end

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
        # @raise [InvalidSyntax] The required block was not given.
        # @return [Array<Interface>]
        def views(&block)
          unless block_given?
            fail InvalidSyntax, "'#{__callee__}' requires a block."
          end

          store(:store_deferred, &block)
        end

        private

        def composition(&block)
          Vedeu::Composition.build({}, &block)
        end

        def store(method, &block)
          composition(&block).interfaces.map { |i| i.public_send(method) }
        end

        # @param method [Symbol] The name of the method sought.
        # @param args [Array] The arguments which the method was to be invoked
        #   with.
        # @param block [Proc] The optional block provided to the method.
        # @return []
        def method_missing(method, *args, &block)
          Vedeu.log("!!!method_missing '#{method}' (args: #{args.inspect})")

          @client_binding.send(method, *args, &block) if @client_binding
        end

      end

    end # View

  end # DSL

end # Vedeu
