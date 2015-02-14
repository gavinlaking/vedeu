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
    #   # Borders can be defined as part of a view definition...
    #   Vedeu.renders do
    #     view 'border_demo' do
    #       border do
    #         # ...
    #
    #   # ...or standalone; referencing the target interface or view.
    #   Vedeu.border 'some_interface' do
    #     # ...
    #
    class Border

      include Vedeu::DSL
      include Vedeu::DSL::Colour
      include Vedeu::DSL::Style

      class << self

        # Specify the border of an interface or view with a simple DSL.
        #
        # @example
        #   Vedeu.border 'some_interface' do
        #     # ...
        #
        # @param name [String] The name of the interface or view to which this
        #   border belongs.
        # @param block [Proc]
        # @return [Vedeu::Border]
        def border(name, &block)
          fail InvalidSyntax, 'block not given' unless block_given?

          Vedeu::Border.build({ enabled: true, name: name }, &block).store
        end

      end

      # Returns an instance of DSL::Border.
      #
      # @param model [Border]
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
        model.attributes[:bottom_left] = char
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
        model.attributes[:bottom_right] = char
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
        model.attributes[:horizontal] = char
      end

      # Enable/disable the bottom border.
      #
      # @example
      #   Vedeu.renders do
      #     view 'border_demo' do
      #       border do
      #         show_bottom false
      #         # ...
      #
      # @param boolean [Boolean] All values evaluate as true except nil and
      #   false.
      # @return [Boolean]
      def show_bottom(boolean)
        model.attributes[:show_bottom] = !!boolean
      end

      # Enable/disable the left border.
      #
      # @example
      #   Vedeu.renders do
      #     view 'border_demo' do
      #       border do
      #         show_left false
      #         # ...
      #
      # @param boolean [Boolean] All values evaluate as true except nil and
      #   false.
      # @return [Boolean]
      def show_left(boolean)
        model.attributes[:show_left] = !!boolean
      end

      # Enable/disable the right border.
      #
      # @example
      #   Vedeu.renders do
      #     view 'border_demo' do
      #       border do
      #         show_right false
      #         # ...
      #
      # @param boolean [Boolean] All values evaluate as true except nil and
      #   false.
      # @return [Boolean]
      def show_right(boolean)
        model.attributes[:show_right] = !!boolean
      end

      # Enable/disable the top border.
      #
      # @example
      #   Vedeu.renders do
      #     view 'border_demo' do
      #       border do
      #         show_top false
      #         # ...
      #
      # @param boolean [Boolean] All values evaluate as true except nil and
      #   false.
      # @return [Boolean]
      def show_top(boolean)
        model.attributes[:show_top] = !!boolean
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
        model.attributes[:top_left] = char
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
        model.attributes[:top_right] = char
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
        model.attributes[:vertical] = char
      end

      private

      attr_reader :client, :model

    end # Border

  end # DSL

end # Vedeu
