require 'vedeu/dsl/colour'
require 'vedeu/dsl/style'

module Vedeu

  module DSL

    # DSL for creating borders for interfaces.
    #
    # Allows customisation for the border's sides and corners; a custom
    # foreground and background, style, and whether a particular side should be
    # drawn or not.
    class Border

      include DSL::Colour
      include DSL::Style

      # Returns an instance of DSL::Border.
      #
      # @param model [Border]
      def initialize(model)
        @model = model
      end

      # @param char [String] Character to be used as the bottom left border
      #   character.
      # @return [String]
      def bottom_left(char)
        model.attributes[:bottom_left] = char
      end

      # @param char [String] Character to be used as the bottom right border
      #   character.
      # @return [String]
      def bottom_right(char)
        model.attributes[:bottom_right] = char
      end

      # @param char [String] Character to be used as the horizontal border
      #   character.
      # @return [String]
      def horizontal(char)
        model.attributes[:horizontal] = char
      end

      # @param boolean [Boolean] All values evaluate as true except nil and
      #   false.
      # @return [Boolean]
      def show_bottom(boolean)
        model.attributes[:show_bottom] = !!boolean
      end

      # @param boolean [Boolean] All values evaluate as true except nil and
      #   false.
      # @return [Boolean]
      def show_left(boolean)
        model.attributes[:show_bottom] = !!boolean
      end

      # @param boolean [Boolean] All values evaluate as true except nil and
      #   false.
      # @return [Boolean]
      def show_right(boolean)
        model.attributes[:show_bottom] = !!boolean
      end

      # @param boolean [Boolean] All values evaluate as true except nil and
      #   false.
      # @return [Boolean]
      def show_top(boolean)
        model.attributes[:show_bottom] = !!boolean
      end

      # @param char [String] Character to be used as the top left border
      #   character.
      # @return [String]
      def top_left(char)
        model.attributes[:top_left] = char
      end

      # @param char [String] Character to be used as the top right border
      #   character.
      # @return [String]
      def top_right(char)
        model.attributes[:top_right] = char
      end

      # @param char [String] Character to be used as the vertical border
      #   character.
      # @return [String]
      def vertical(char)
        model.attributes[:vertical] = char
      end

      private

      attr_reader :model

    end # Border

  end # DSL

end # Vedeu
