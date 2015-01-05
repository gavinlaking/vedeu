require 'vedeu/support/common'

module Vedeu

  module DSL

    class Composition

      include Vedeu::Common

      class << self

        # Directly write a view buffer to the terminal. Using this method means
        # that the refresh event does not need to be triggered after creating
        # the view or views, though can be later triggered if needed.
        #
        # @param block [Proc] The directives you wish to send to render. Must
        #   include `view` or `views` with associated sub-directives.
        #
        # @example
        #   Vedeu.render do
        #     views do
        #       view 'my_interface' do
        #         ...
        #
        #   Vedeu.render do
        #     view 'my_interface' do
        #       ...
        #
        # @raise [InvalidSyntax] When the required block is not given.
        # @return [Array] A collection of strings, each defining containing the
        #   escape sequences and content. This data has already been sent to the
        #   terminal to be output.
        def render(&block)
          return requires_block(__callee__) unless block_given?

          composition = Vedeu::Composition.build([], nil, nil, &block)

          composition.interfaces.map do |interface|
            Buffers.add_content(interface.attributes)

            interface.name
          end.map { |name| Vedeu::Refresh.by_name(name) }
        end
        alias_method :renders, :render

      end

      # Returns an instance of DSL::Composition.
      #
      # @param model [Composition]
      def initialize(model)
        @model = model
      end

      # Directly write a view buffer to the terminal. Using this method means
      # that the refresh event does not need to be triggered after creating the
      # view or views, though can be later triggered if needed.
      #
      # @param block [Proc] The directives you wish to send to render. Must
      #   include `view` or `views` with associated sub-directives.
      #
      # @example
      #   Vedeu.render do
      #     views do
      #       view 'my_interface' do
      #         ...
      #
      #   Vedeu.render do
      #     view 'my_interface' do
      #       ...
      #
      # @raise [InvalidSyntax] When the required block is not given.
      # @return [Array] A collection of strings, each defining containing the
      #   escape sequences and content. This data has already been sent to the
      #   terminal to be output.
      def render(&block)
        return requires_block(__callee__) unless block_given?

        Vedeu::Composition.build([], nil, nil, &block).interfaces.map do |interface|
          Buffers.add_content(interface.attributes)

          interface.name
        end.map { |name| Vedeu::Refresh.by_name(name) }
      end
      alias_method :renders, :render

      # Define a view (content) for an interface.
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
      alias_method :interfaces, :view

      # Instruct Vedeu to treat contents of block as a single composition.
      #
      # @note The views declared within this block are stored in their
      #   respective interface back buffers until a refresh event occurs. When
      #   the refresh event is triggered, the back buffers are swapped into the
      #   front buffers and the content here will be rendered to
      #   {Terminal.output}.
      #
      # @param block [Proc] Instructs Vedeu to treat all of the 'view'/'views'
      #   directives therein as one instruction. Useful for redrawing multiple
      #   interfaces at once.
      #
      # @example
      #   views do
      #     view 'my_interface' do
      #       ... some attributes ...
      #     end
      #     view 'my_other_interface' do
      #       ... some other attributes ...
      #     end
      #     ...
      #
      #   composition do
      #     view 'my_interface' do
      #       ...
      #   ...
      #
      # @raise [InvalidSyntax] When the required block is not given.
      # @return [Array]
      def views(&block)
        return requires_block(__callee__) unless block_given?

        Vedeu::Composition.build(&block)
      end
      alias_method :composition, :views

      private

      attr_reader :model

    end # Composition

  end # DSL

end # Vedeu
