module Vedeu

  module Borders

    # Provides a mechanism to help configure borders in Vedeu.
    #
    class DSL

      include Vedeu::DSL
      include Vedeu::DSL::Border
      include Vedeu::DSL::Presentation
      include Vedeu::DSL::Use

      # {include:file:docs/dsl/by_method/border.md}
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

      # {include:file:docs/dsl/by_method/bottom_left.md}
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

      # {include:file:docs/dsl/by_method/bottom_right.md}
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

      # {include:file:docs/dsl/by_method/disable.md}
      # @return [Boolean]
      def disable!
        model.enabled = false

        hide_bottom!
        hide_left!
        hide_right!
        hide_top!

        model.enabled
      end
      alias_method :disabled!, :disable!

      # {include:file:docs/dsl/by_method/enable.md}
      # @return [Boolean]
      def enable!
        model.enabled = true

        show_bottom!
        show_left!
        show_right!
        show_top!

        model.enabled
      end
      alias_method :enabled!, :enable!

      # {include:file:docs/dsl/by_method/top_horizontal.md}
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

      # {include:file:docs/dsl/by_method/bottom_horizontal.md}
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

      # {include:file:docs/dsl/by_method/horizontal.md}
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

      # {include:file:docs/dsl/by_method/bottom.md}
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

      # {include:file:docs/dsl/by_method/left.md}
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

      # {include:file:docs/dsl/by_method/right.md}
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

      # {include:file:docs/dsl/by_method/title.md}
      # @param value [String] The title.
      # @return [String]
      def title(value)
        model.title = value
        model.title
      end
      alias_method :title=, :title

      # {include:file:docs/dsl/by_method/caption.md}
      # @param value [String] The caption.
      # @return [String]
      def caption(value)
        model.caption = value
        model.caption
      end
      alias_method :caption=, :caption

      # {include:file:docs/dsl/by_method/top.md}
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

      # {include:file:docs/dsl/by_method/top_left.md}
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

      # {include:file:docs/dsl/by_method/top_right.md}
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

      # {include:file:docs/dsl/by_method/left_vertical.md}
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

      # {include:file:docs/dsl/by_method/right_vertical.md}
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

      # {include:file:docs/dsl/by_method/vertical.md}
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
