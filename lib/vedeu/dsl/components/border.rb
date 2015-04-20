require 'vedeu/output/border'
require 'vedeu/dsl/shared/all'

module Vedeu

  module DSL

    # DSL for creating borders for interfaces.
    #
    # Allows customisation for the border's sides and corners; a custom
    # foreground and background, style, and whether a particular side should be
    # drawn or not.
    #
    # @example
    #   # Borders can be defined when defining your interface...
    #   Vedeu.interface 'my_interface' do
    #     border do
    #       # ...
    #
    #   # ...or as part of a view definition...
    #   Vedeu.renders do
    #     view 'border_demo' do
    #       border do
    #         # ...
    #
    #   # ...or standalone; referencing the target interface or view.
    #   Vedeu.border 'some_interface' do
    #     # ...
    class Border

      include Vedeu::DSL
      include Vedeu::DSL::Presentation

      # Specify the border of an interface or view with a simple DSL.
      #
      # @example
      #   Vedeu.border 'some_interface' do
      #     # ...
      #
      # @param name [String] The name of the interface or view to which this
      #   border belongs.
      # @param block [Proc]
      # @raise [InvalidSyntax] The required block was not given.
      # @return [Vedeu::Border]
      def self.border(name, &block)
        fail InvalidSyntax, 'block not given' unless block_given?

        Vedeu::Border.build({ enabled: true, name: name }, &block).store
      end

      # Returns an instance of DSL::Border.
      #
      # @param model [Border]
      # @param client [Object]
      # @return [Vedeu::DSL::Border]
      def initialize(model, client = nil)
        @model  = model
        @client = client
      end

      # Set the character to be used to draw the bottom left corner of the
      # border.
      #
      # @example
      #   Vedeu.renders do
      #     view 'border_demo' do
      #       border do
      #         bottom_left '+'
      #         # ...
      #
      # @param char [String] Character to be used as the bottom left border
      #   character.
      # @return [String]
      def bottom_left(char)
        model.bottom_left = char
      end

      # Set the character to be used to draw the bottom right corner of the
      # border.
      #
      # @example
      #   Vedeu.renders do
      #     view 'border_demo' do
      #       border do
      #         bottom_right '+'
      #         # ...
      #
      # @param char [String] Character to be used as the bottom right border
      #   character.
      # @return [String]
      def bottom_right(char)
        model.bottom_right = char
      end

      # Set the character to be used to draw a horizontal part of the border.
      #
      # @example
      #   Vedeu.renders do
      #     view 'border_demo' do
      #       border do
      #         horizontal '-'
      #         # ...
      #
      # @param char [String] Character to be used as the horizontal border
      #   character.
      # @return [String]
      def horizontal(char)
        model.horizontal = char
      end

      # Enable/disable the bottom border.
      #
      # @example
      #   Vedeu.renders do
      #     view 'border_demo' do
      #       border do
      #         bottom false
      #         # ... or
      #         hide_bottom!
      #         # ... or
      #         show_bottom!
      #
      # @param value [Boolean] All values evaluate as true except nil and
      #   false.
      # @return [Boolean]
      def bottom(value)
        boolean = value ? true : false

        model.show_bottom = boolean
      end
      alias_method :show_bottom, :bottom

      # @see #bottom
      def hide_bottom!
        bottom(false)
      end

      # @see #bottom
      def show_bottom!
        bottom(true)
      end

      # Enable/disable the left border.
      #
      # @example
      #   Vedeu.renders do
      #     view 'border_demo' do
      #       border do
      #         left false
      #         # ... or
      #         hide_left!
      #         # ... or
      #         show_left!
      #
      # @param value [Boolean] All values evaluate as true except nil and
      #   false.
      # @return [Boolean]
      def left(value)
        boolean = value ? true : false

        model.show_left = boolean
      end
      alias_method :show_left, :left

      # @see #left
      def hide_left!
        left(false)
      end

      # @see #left
      def show_left!
        left(true)
      end

      # Enable/disable the right border.
      #
      # @example
      #   Vedeu.renders do
      #     view 'border_demo' do
      #       border do
      #         right false
      #         # ... or
      #         hide_right!
      #         # ... or
      #         show_right!
      #
      # @param value [Boolean] All values evaluate as true except nil and
      #   false.
      # @return [Boolean]
      def right(value)
        boolean = value ? true : false

        model.show_right = boolean
      end
      alias_method :show_right, :right

      # @see #right
      def hide_right!
        right(false)
      end

      # @see #right
      def show_right!
        right(true)
      end

      # If you have you are showing a top border, you could add a title.
      #
      # @example
      #   Vedeu.renders do
      #     view 'border_demo' do
      #       geometry { width: 50 }
      #       border do
      #         title 'My Cool Title'
      #         # ...
      #
      #   +- My Cool Title --------------------------------+
      #
      # @param value [String] The title.
      # @return [String]
      def title(value)
        model.title = value
      end

      # Enable/disable the top border.
      #
      # @example
      #   Vedeu.renders do
      #     view 'border_demo' do
      #       border do
      #         top false
      #         # ... or
      #         hide_top!
      #         # ... or
      #         show_top!
      #
      # @param value [Boolean] All values evaluate as true except nil and
      #   false.
      # @return [Boolean]
      def top(value)
        boolean = value ? true : false

        model.show_top = boolean
      end
      alias_method :show_top, :top

      # @see #top
      def hide_top!
        top(false)
      end

      # @see #top
      def show_top!
        top(true)
      end

      # Set the character to be used to draw the top left corner of the border.
      #
      # @example
      #   Vedeu.renders do
      #     view 'border_demo' do
      #       border do
      #         top_left '+'
      #         # ...
      #
      # @param char [String] Character to be used as the top left border
      #   character.
      # @return [String]
      def top_left(char)
        model.top_left = char
      end

      # Set the character to be used to draw the top right corner of the border.
      #
      # @example
      #   Vedeu.renders do
      #     view 'border_demo' do
      #       border do
      #         top_right '+'
      #         # ...
      #
      # @param char [String] Character to be used as the top right border
      #   character.
      # @return [String]
      def top_right(char)
        model.top_right = char
      end

      # Set the character to be used to draw a vertical part of the border.
      #
      # @example
      #   Vedeu.renders do
      #     view 'border_demo' do
      #       border do
      #         vertical '|'
      #         # ...
      #
      # @param char [String] Character to be used as the vertical border
      #   character.
      # @return [String]
      def vertical(char)
        model.vertical = char
      end

      protected

      # @!attribute [r] client
      # @return [Object]
      attr_reader :client

      # @!attribute [r] model
      # @return [Border]
      attr_reader :model

    end # Border

  end # DSL

end # Vedeu
