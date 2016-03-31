# frozen_string_literal: true

module Vedeu

  module Borders

    # Provides the mechanism to decorate an interface with a border on
    # all edges, or specific edges. The characters which are used for
    # the border parts (e.g. the corners, verticals and horizontals)
    # can be customised as can the colours and styles.
    #
    # More information can be found at: {file:docs/borders.md Borders}
    #
    # @note
    #   Refer to UTF-8 U+2500 to U+257F for border characters.
    #   More details can be found at:
    #   http://en.wikipedia.org/wiki/Box-drawing_character
    #
    # @api private
    #
    class Border

      extend Forwardable
      include Vedeu::Repositories::Model
      include Vedeu::Presentation
      include Vedeu::Presentation::Colour
      include Vedeu::Presentation::Position
      include Vedeu::Presentation::Styles

      # @!attribute [w] bottom_left
      # @return [String] The character to be used for the bottom left
      #   border if enabled.
      attr_writer :bottom_left

      # @!attribute [w] bottom_right
      # @return [String] The character to be used for the bottom right
      #   border if enabled.
      attr_writer :bottom_right

      # @!attribute [w] bottom_horizontal
      # @return [String] The character to be used for the bottom
      #   horizontal border if enabled.
      attr_writer :bottom_horizontal

      # @!attribute [r] caption
      # @return [String] An optional caption for when the bottom
      #   border is to be shown.
      attr_reader :caption

      # @!attribute [rw] horizontal
      # @return [String] The character to be used for the horizontal
      #   side border.
      attr_accessor :horizontal

      # @!attribute [rw] show_bottom
      # @return [Boolean] Determines whether the bottom border should
      #   be shown.
      attr_accessor :show_bottom
      alias bottom? show_bottom

      # @!attribute [rw] show_left
      # @return [Boolean] Determines whether the left border should
      #   be shown.
      attr_accessor :show_left
      alias left? show_left

      # @!attribute [rw] show_right
      # @return [Boolean] Determines whether the right border should
      #   be shown.
      attr_accessor :show_right
      alias right? show_right

      # @!attribute [rw] show_top
      # @return [Boolean] Determines whether the top border should
      #   be shown.
      attr_accessor :show_top
      alias top? show_top

      # @!attribute [r] title
      # @return [String] An optional title for when the top border is
      #   to be shown.
      attr_reader :title

      # @!attribute [w] top_left
      # @return [String] The character to be used for the top left
      #   border if enabled.
      attr_writer :top_left

      # @!attribute [w] top_right
      # @return [String] The character to be used for the top right
      #   border if enabled.
      attr_writer :top_right

      # @!attribute [w] top_horizontal
      # @return [String] The character to be used for the top
      #   horizontal border if enabled.
      attr_writer :top_horizontal

      # @!attribute [rw] vertical
      # @return [String] The character to be used for the vertical
      #   side border.
      attr_accessor :vertical

      # @!attribute [w] left_vertical
      # @return [String] The character to be used for the left
      #   vertical side border.
      attr_writer :left_vertical

      # @!attribute [w] right_vertical
      # @return [String] The character to be used for the right
      #   vertical side border.
      attr_writer :right_vertical

      # @!attribute [r] name
      # @macro return_name
      attr_reader :name

      # @!attribute [r] parent
      # @return [Vedeu::Interfaces::Interface|NilClass] The interface/
      #   view associated with this border.
      attr_reader :parent

      # @!attribute [rw] enabled
      # @return [Boolean] Determines whether this border should be
      #   rendered.
      attr_accessor :enabled
      alias enabled? enabled

      # Returns a new instance of Vedeu::Borders::Border.
      #
      # @param attributes [Hash<Symbol => Boolean|Hash|NilClass|
      #   String|Symbol|Vedeu::Borders::Repository|
      #   Vedeu::Presentation::Style>]
      # @option attributes bottom_left [String]
      #   The bottom left border character.
      # @option attributes bottom_right [String]
      #   The bottom right border character.
      # @option attributes colour [Hash]
      # @option attributes enabled [Boolean] Indicate whether the
      #   border is to be shown for this interface.
      # @option attributes horizontal [String]
      #   The horizontal border character.
      # @option attributes left_vertical [String]
      #   The left vertical border character.
      # @option attributes name [String|Symbol] The name of the
      #   interface to which this border relates.
      # @option attributes right_vertical [String]
      #   The right vertical border character.
      # @option attributes style [Vedeu::Presentation::Style]
      # @option attributes show_bottom [Boolean] Indicate whether the
      #   bottom border is to be shown.
      # @option attributes show_left [Boolean] Indicate whether the
      #   left border is to be shown.
      # @option attributes show_right [Boolean] Indicate whether the
      #   right border is to be shown.
      # @option attributes show_top [Boolean] Indicate whether the top
      #   border is to be shown.
      # @option attributes title [String] An optional title for when
      #   the top border is to be shown.
      # @option attributes caption [String] An optional caption for
      #   when the bottom border is to be shown.
      # @option attributes top_horizontal [String]
      #   The top horizontal border character.
      # @option attributes top_left [String]
      #   The top left border character.
      # @option attributes top_right [String]
      #   The top right border character.
      # @option attributes vertical [String]
      #   The vertical border character.
      # @return [Vedeu::Borders::Border]
      def initialize(attributes = {})
        defaults.merge!(attributes).each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # @return [Hash<Symbol => Boolean|Hash|NilClass|String|Symbol|
      #   Vedeu::Borders::Repository|Vedeu::Presentation::Style>]
      def attributes
        {
          bottom_horizontal: bottom_horizontal,
          bottom_left:       bottom_left,
          bottom_right:      bottom_right,
          caption:           caption,
          client:            @client,
          colour:            colour,
          enabled:           @enabled,
          horizontal:        @horizontal,
          left_vertical:     left_vertical,
          name:              name,
          parent:            @parent,
          repository:        @repository,
          right_vertical:    right_vertical,
          show_bottom:       @show_bottom,
          show_left:         @show_left,
          show_right:        @show_right,
          show_top:          @show_top,
          style:             style,
          title:             title,
          top_horizontal:    top_horizontal,
          top_left:          top_left,
          top_right:         top_right,
          vertical:          @vertical,
        }
      end

      # @param value [String]
      # @return [Vedeu::Borders::Border]
      def caption=(value)
        @caption = value

        store
      end

      # Returns a DSL instance responsible for defining the DSL
      # methods of this model.
      #
      # @param client [Object|NilClass] The client binding represents
      #   the client application object that is currently invoking a
      #   DSL method. It is required so that we can send messages to
      #   the client application object should we need to.
      # @return [Vedeu::Borders::DSL] The DSL instance for this model.
      def deputy(client = nil)
        Vedeu::Borders::DSL.new(self, client)
      end

      # Return the client application configured left vertical cell
      # character, or the default if not set.
      #
      # @return [Vedeu::Cells::LeftVertical]
      def left_vertical
        @left_vertical ||= Vedeu::Cells::LeftVertical.new(cell_attributes)
      end

      # Return the client application configured right vertical cell
      # character, or the default if not set.
      #
      # @return [Vedeu::Cells::RightVertical]
      def right_vertical
        @right_vertical ||= Vedeu::Cells::RightVertical.new(cell_attributes)
      end

      # Return the client application configured top horizontal cell
      # character, or the default if not set.
      #
      # @return [Vedeu::Cells::TopHorizontal]
      def top_horizontal
        @top_horizontal ||= Vedeu::Cells::TopHorizontal.new(cell_attributes)
      end

      # Return the client application configured top left cell
      # character, or the default if not set.
      #
      # @return [Vedeu::Cells::TopLeft]
      def top_left
        @top_left ||= Vedeu::Cells::TopLeft.new(cell_attributes)
      end

      # Return the client application configured top right cell
      # character, or the default if not set.
      #
      # @return [Vedeu::Cells::TopRight]
      def top_right
        @top_right ||= Vedeu::Cells::TopRight.new(cell_attributes)
      end

      # Return the client application configured bottom horizontal
      # cell character, or the default if not set.
      #
      # @return [Vedeu::Cells::BottomHorizontal]
      def bottom_horizontal
        @bottom_horizontal ||= Vedeu::Cells::BottomHorizontal
                               .new(cell_attributes)
      end

      # Return the client application configured bottom left cell
      # character, or the default if not set.
      #
      # @return [Vedeu::Cells::BottomLeft]
      def bottom_left
        @bottom_left ||= Vedeu::Cells::BottomLeft.new(cell_attributes)
      end

      # Return the client application configured bottom right cell
      # character, or the default if not set.
      #
      # @return [Vedeu::Cells::BottomRight]
      def bottom_right
        @bottom_right ||= Vedeu::Cells::BottomRight.new(cell_attributes)
      end

      # @param value [String]
      # @return [Vedeu::Borders::Border]
      def title=(value)
        @title = value

        store
      end

      private

      # @return [Hash<Symbol => void>]
      def cell_attributes
        {
          colour: colour,
          name:   name,
          style:  style,
        }
      end

      # @macro defaults_method
      def defaults
        {
          bottom_horizontal: nil,
          bottom_left:       nil,
          bottom_right:      nil,
          caption:           '',
          client:            nil,
          colour:            nil,
          enabled:           false,
          horizontal:        Vedeu.esc.horizontal,
          left_vertical:     nil,
          name:              nil,
          parent:            nil,
          repository:        Vedeu.borders,
          right_vertical:    nil,
          show_bottom:       true,
          show_left:         true,
          show_right:        true,
          show_top:          true,
          style:             nil,
          title:             '',
          top_horizontal:    nil,
          top_left:          nil,
          top_right:         nil,
          vertical:          Vedeu.esc.vertical,
        }
      end

    end # Border

  end # Borders

end # Vedeu
