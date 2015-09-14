module Vedeu

  module Borders

    # Provides a mechanism to help configure borders in Vedeu.
    #
    class DSL

      include Vedeu::DSL
      include Vedeu::DSL::Presentation
      include Vedeu::DSL::Use

      # Specify the border of an interface or view with a simple DSL.
      #
      #   Vedeu.border 'some_interface' do
      #     # ...
      #   end
      #
      # @param name [String] The name of the interface or view to which this
      #   border belongs.
      # @param block [Proc]
      # @raise [Vedeu::Error::InvalidSyntax]
      #   The required block was not given.
      # @return [Vedeu::Borders::Border]
      def self.border(name, &block)
        fail Vedeu::Error::InvalidSyntax, 'block not given' unless block_given?

        Vedeu::Borders::Border.build(enabled: true, name: name, &block).store
      end

      # Returns an instance of Borders::DSL.
      #
      # @param model [Vedeu::Borders::Border]
      # @param client [Object]
      # @return [Vedeu::Borders::DSL]
      def initialize(model, client = nil)
        @model  = model
        @client = client
      end

      # Set the character to be used to draw the bottom left corner of the
      # border.
      #
      #   Vedeu.border 'border_demo' do
      #     bottom_left '+'
      #     # ... some code
      #   end
      #
      # @param char [String] Character to be used as the bottom left border
      #   character.
      # @return [String]
      def bottom_left(char)
        model.bottom_left = char
      end
      alias_method :bottom_left=, :bottom_left

      # Set the character to be used to draw the bottom right corner of the
      # border.
      #
      #   Vedeu.border 'border_demo' do
      #     bottom_right '+'
      #     # ... some code
      #   end
      #
      # @param char [String] Character to be used as the bottom right border
      #   character.
      # @return [String]
      def bottom_right(char)
        model.bottom_right = char
      end
      alias_method :bottom_right=, :bottom_right

      # Disable the border:
      #
      #   Vedeu.border 'border_demo' do
      #     disable!
      #     # ... some other code (will be ignored)
      #   end
      #
      # @return [Boolean]
      def disable!
        model.enabled = false

        hide_bottom!
        hide_left!
        hide_right!
        hide_top!

        model.enabled
      end

      # Enable the border:
      # (Borders are enabled by default when defined for an interface).
      #
      #   Vedeu.border 'border_demo' do
      #     enable!
      #     # ... some code
      #   end
      #
      # @return [Boolean]
      def enable!
        model.enabled = true

        show_bottom!
        show_left!
        show_right!
        show_top!

        model.enabled
      end

      # Set the character to be used to draw a horizontal part of the border.
      #
      #   Vedeu.border 'border_demo' do
      #     horizontal '-'
      #     # ... some code
      #   end
      #
      # @param char [String] Character to be used as the horizontal border
      #   character.
      # @return [String]
      def horizontal(char)
        model.horizontal = char
      end
      alias_method :horizontal=, :horizontal

      # Enable/disable the bottom border.
      #
      #   Vedeu.border 'border_demo' do
      #     bottom true  # or...
      #     bottom false # or...
      #     hide_bottom! # or...
      #     show_bottom!
      #     # ... some code
      #   end
      #
      # @param value [Boolean] All values evaluate as true except nil and
      #   false.
      # @return [Boolean]
      def bottom(value)
        boolean = value ? true : false

        model.show_bottom = boolean
      end
      alias_method :show_bottom, :bottom
      alias_method :bottom=, :bottom

      # Disable the bottom border.
      #
      # @see Vedeu::Borders::DSL#bottom
      def hide_bottom!
        bottom(false)
      end

      # Enable the bottom border.
      #
      # @see Vedeu::Borders::DSL#bottom
      def show_bottom!
        bottom(true)
      end

      # Enable/disable the left border.
      #
      #   Vedeu.border 'border_demo' do
      #     left true  # or...
      #     left false # or...
      #     hide_left! # or...
      #     show_left!
      #     # ... some code
      #   end
      #
      # @param value [Boolean] All values evaluate as true except nil and
      #   false.
      # @return [Boolean]
      def left(value)
        boolean = value ? true : false

        model.show_left = boolean
      end
      alias_method :show_left, :left
      alias_method :left=, :left

      # Disable the left border.
      #
      # @see Vedeu::Borders::DSL#left
      def hide_left!
        left(false)
      end

      # Enable the left border.
      #
      # @see Vedeu::Borders::DSL#left
      def show_left!
        left(true)
      end

      # Enable/disable the right border.
      #
      #   Vedeu.border 'border_demo' do
      #     right true  # or...
      #     right false # or...
      #     hide_right! # or...
      #     show_right!
      #     # ... some code
      #   end
      #
      # @param value [Boolean] All values evaluate as true except nil and
      #   false.
      # @return [Boolean]
      def right(value)
        boolean = value ? true : false

        model.show_right = boolean
      end
      alias_method :show_right, :right
      alias_method :right=, :right

      # Disable the right border.
      #
      # @see Vedeu::Borders::DSL#right
      def hide_right!
        right(false)
      end

      # Enable the right border.
      #
      # @see Vedeu::Borders::DSL#right
      def show_right!
        right(true)
      end

      # If you have you are showing a top border, you could add a title.
      #
      #   Vedeu.border 'border_demo' do
      #     title 'My Cool Title'
      #     # ... some code
      #   end
      #
      # produces, depending on other customisations:
      #
      #   +- My Cool Title --------------------------------+
      #
      # @param value [String] The title.
      # @return [String]
      def title(value)
        model.title = value
      end
      alias_method :title=, :title

      # If you have you are showing a bottom border, you could add a caption.
      #
      #   Vedeu.border 'border_demo' do
      #     caption 'My Cool Caption'
      #     # ... some code
      #   end
      #
      # produces, depending on other customisations:
      #
      #   +------------------------------ My Cool Caption -+
      #
      # @param value [String] The caption.
      # @return [String]
      def caption(value)
        model.caption = value
      end
      alias_method :caption=, :caption

      # Enable/disable the top border.
      #
      #   Vedeu.border 'border_demo' do
      #     top true  # or...
      #     top false # or...
      #     hide_top! # or...
      #     show_top!
      #     # ... some code
      #   end
      #
      # @param value [Boolean] All values evaluate as true except nil and
      #   false.
      # @return [Boolean]
      def top(value)
        boolean = value ? true : false

        model.show_top = boolean
      end
      alias_method :show_top, :top
      alias_method :top=, :top

      # Disable the top border.
      #
      # @see Vedeu::Borders::DSL#top
      def hide_top!
        top(false)
      end

      # Enable the top border.
      #
      # @see Vedeu::Borders::DSL#top
      def show_top!
        top(true)
      end

      # Set the character to be used to draw the top left corner of the border.
      #
      #   Vedeu.border 'border_demo' do
      #     top_left '+'
      #     # ... some code
      #   end
      #
      # @param char [String] Character to be used as the top left border
      #   character.
      # @return [String]
      def top_left(char)
        model.top_left = char
      end
      alias_method :top_left=, :top_left

      # Set the character to be used to draw the top right corner of the border.
      #
      #   Vedeu.border 'border_demo' do
      #     top_right '+'
      #     # ... some code
      #   end
      #
      # @param char [String] Character to be used as the top right border
      #   character.
      # @return [String]
      def top_right(char)
        model.top_right = char
      end
      alias_method :top_right=, :top_right

      # Set the character to be used to draw a vertical part of the border.
      #
      #   Vedeu.border 'border_demo' do
      #     vertical '|'
      #     # ... some code
      #   end
      #
      # @param char [String] Character to be used as the vertical border
      #   character.
      # @return [String]
      def vertical(char)
        model.vertical = char
      end
      alias_method :vertical=, :vertical

    end # Border

  end # DSL

end # Vedeu
