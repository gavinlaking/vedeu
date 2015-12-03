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
      #   Vedeu.border :some_interface do
      #     # ...
      #   end
      #
      # @param name [String|Symbol] The name of the interface or view
      #   to which this border belongs.
      # @param block [Proc]
      # @raise [Vedeu::Error::MissingRequired|
      #   Vedeu::Error::RequiresBlock] When a name or block
      #   respectively are not given.
      # @return [Vedeu::Borders::Border]
      def self.border(name, &block)
        fail Vedeu::Error::MissingRequired unless name
        fail Vedeu::Error::RequiresBlock unless block_given?

        Vedeu::Borders::Border.build(enabled: true, name: name, &block).store
      end

      # Set the character to be used to draw the bottom left corner of
      # the border.
      #
      #   Vedeu.border :border_demo do
      #     bottom_left '+'
      #     # ... some code
      #   end
      #
      # @param char [String] Character to be used as the bottom left
      #   border character.
      # @param options [Hash<Symbol => Hash<Symbol => String>|String|
      #   Symbol]
      # @option options colour [Hash<Symbol => String>]
      # @option options style [String|Symbol]
      # @return [String]
      def bottom_left(char, options = {})
        model.bottom_left = Vedeu::Cells::BottomLeft.new(attrs(char, options))
      end
      alias_method :bottom_left=, :bottom_left

      # Set the character to be used to draw the bottom right corner
      # of the border.
      #
      #   Vedeu.border :border_demo do
      #     bottom_right '+'
      #     # ... some code
      #   end
      #
      # @param char [String] Character to be used as the bottom right
      #   border character.
      # @param options [Hash<Symbol => Hash<Symbol => String>|String|
      #   Symbol]
      # @option options colour [Hash<Symbol => String>]
      # @option options style [String|Symbol]
      # @return [String]
      def bottom_right(char, options = {})
        model.bottom_right = Vedeu::Cells::BottomRight.new(attrs(char, options))
      end
      alias_method :bottom_right=, :bottom_right

      # Disable the border:
      #
      #   Vedeu.border :border_demo do
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
      # (Borders are enabled by default when defined for an
      # interface).
      #
      #   Vedeu.border :border_demo do
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

      # Set the character to be used to draw the top horizontal part
      # of the border.
      #
      #   Vedeu.border :border_demo do
      #     top_horizontal '-'
      #     # ... some code
      #   end
      #
      # @param char [String] Character to be used as the top
      #   horizontal border character.
      # @param options [Hash<Symbol => Hash<Symbol => String>|String|
      #   Symbol]
      # @option options colour [Hash<Symbol => String>]
      # @option options style [String|Symbol]
      # @return [String]
      def top_horizontal(char, options = {})
        model.top_horizontal = Vedeu::Cells::TopHorizontal
          .new(attrs(char, options))
      end
      alias_method :top_horizontal=, :top_horizontal

      # Set the character to be used to draw the bottom horizontal
      # part of the border.
      #
      #   Vedeu.border :border_demo do
      #     bottom_horizontal '-'
      #     # ... some code
      #   end
      #
      # @param char [String] Character to be used as the bottom
      #   horizontal border character.
      # @param options [Hash<Symbol => Hash<Symbol => String>|String|
      #   Symbol]
      # @option options colour [Hash<Symbol => String>]
      # @option options style [String|Symbol]
      # @return [String]
      def bottom_horizontal(char, options = {})
        model.bottom_horizontal = Vedeu::Cells::BottomHorizontal
          .new(attrs(char, options))
      end
      alias_method :bottom_horizontal=, :bottom_horizontal

      # Set the character to be used to draw a horizontal part of the
      # border.
      #
      #   Vedeu.border :border_demo do
      #     horizontal '-'
      #     # ... some code
      #   end
      #
      # @param char [String] Character to be used as the horizontal
      #   border character.
      # @param options [Hash<Symbol => Hash<Symbol => String>|String|
      #   Symbol]
      # @option options colour [Hash<Symbol => String>]
      # @option options style [String|Symbol]
      # @return [String]
      def horizontal(char, options = {})
        model.horizontal = Vedeu::Cells::Horizontal.new(attrs(char, options))
      end
      alias_method :horizontal=, :horizontal

      # Enable/disable the bottom border.
      #
      #   Vedeu.border :border_demo do
      #     bottom true  # or...
      #     bottom false # or...
      #     hide_bottom! # or...
      #     show_bottom!
      #     # ... some code
      #   end
      #
      # @param value [Boolean] All values evaluate as true except nil
      # and false.
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
      #   Vedeu.border :border_demo do
      #     left true  # or...
      #     left false # or...
      #     hide_left! # or...
      #     show_left!
      #     # ... some code
      #   end
      #
      # @param value [Boolean] All values evaluate as true except nil
      #   and false.
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
      #   Vedeu.border :border_demo do
      #     right true  # or...
      #     right false # or...
      #     hide_right! # or...
      #     show_right!
      #     # ... some code
      #   end
      #
      # @param value [Boolean] All values evaluate as true except nil
      #   and false.
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

      # If you have you are showing a top border, you could add a
      # title.
      #
      #   Vedeu.border :border_demo do
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
        model.title
      end
      alias_method :title=, :title

      # If you have you are showing a bottom border, you could add a
      # caption.
      #
      #   Vedeu.border :border_demo do
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
        model.caption
      end
      alias_method :caption=, :caption

      # Enable/disable the top border.
      #
      #   Vedeu.border :border_demo do
      #     top true  # or...
      #     top false # or...
      #     hide_top! # or...
      #     show_top!
      #     # ... some code
      #   end
      #
      # @param value [Boolean] All values evaluate as true except nil
      #   and false.
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

      # Set the character to be used to draw the top left corner of
      # the border.
      #
      #   Vedeu.border :border_demo do
      #     top_left '+'
      #     # ... some code
      #   end
      #
      # @param char [String] Character to be used as the top left
      #   border character.
      # @param options [Hash<Symbol => Hash<Symbol => String>|String|
      #   Symbol]
      # @option options colour [Hash<Symbol => String>]
      # @option options style [String|Symbol]
      # @return [String]
      def top_left(char, options = {})
        model.top_left = Vedeu::Cells::TopLeft.new(attrs(char, options))
      end
      alias_method :top_left=, :top_left

      # Set the character to be used to draw the top right corner of
      # the border.
      #
      #   Vedeu.border :border_demo do
      #     top_right '+'
      #     # ... some code
      #   end
      #
      # @param char [String] Character to be used as the top right
      #   border character.
      # @param options [Hash<Symbol => Hash<Symbol => String>|String|
      #   Symbol]
      # @option options colour [Hash<Symbol => String>]
      # @option options style [String|Symbol]
      # @return [String]
      def top_right(char, options = {})
        model.top_right = Vedeu::Cells::TopRight.new(attrs(char, options))
      end
      alias_method :top_right=, :top_right

      # Set the character to be used to draw the left vertical part of
      # the border.
      #
      #   Vedeu.border :border_demo do
      #     left_vertical '|'
      #     # ... some code
      #   end
      #
      # @param char [String] Character to be used as the left vertical
      #   border character.
      # @param options [Hash<Symbol => Hash<Symbol => String>|String|
      #   Symbol]
      # @option options colour [Hash<Symbol => String>]
      # @option options style [String|Symbol]
      # @return [String]
      def left_vertical(char, options = {})
        model.left_vertical = Vedeu::Cells::LeftVertical
          .new(attrs(char, options))
      end
      alias_method :left_vertical=, :left_vertical

      # Set the character to be used to draw the right vertical part
      # of the border.
      #
      #   Vedeu.border :border_demo do
      #     right_vertical '|'
      #     # ... some code
      #   end
      #
      # @param char [String] Character to be used as the right
      #   vertical border character.
      # @param options [Hash<Symbol => Hash<Symbol => String>|String|
      #   Symbol]
      # @option options colour [Hash<Symbol => String>]
      # @option options style [String|Symbol]
      # @return [String]
      def right_vertical(char, options = {})
        model.right_vertical = Vedeu::Cells::RightVertical
          .new(attrs(char, options))
      end
      alias_method :right_vertical=, :right_vertical

      # Set the character to be used to draw a vertical part of the
      # border.
      #
      #   Vedeu.border :border_demo do
      #     vertical '|'
      #     # ... some code
      #   end
      #
      # @param char [String] Character to be used as the vertical
      #   border character.
      # @param options [Hash<Symbol => Hash<Symbol => String>|String|
      #   Symbol]
      # @option options colour [Hash<Symbol => String>]
      # @option options style [String|Symbol]
      # @return [String]
      def vertical(char, options = {})
        model.vertical = Vedeu::Cells::Vertical.new(attrs(char, options))
      end
      alias_method :vertical=, :vertical

      private

      # @return [Hash<Symbol => void>]
      def attrs(value, options)
        default_options.merge!(value: value).merge!(options)
      end

      # @return [Hash<Symbol => NilClass|String|Symbol>]
      def default_options
        {
          colour: model.colour,
          name:   model.name,
          style:  model.style,
          value:  nil,
        }
      end

    end # Border

  end # DSL

  # @!method border
  #   @see Vedeu::Borders::DSL.border
  def_delegators Vedeu::Borders::DSL,
                 :border

end # Vedeu
