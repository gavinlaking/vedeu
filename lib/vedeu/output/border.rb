require 'vedeu/dsl/components/border'

module Vedeu

  # Provides the mechanism to decorate an interface with a border on all edges,
  # or specific edges. The characters which are used for the border parts (e.g.
  # the corners, verticals and horizontals) can be customised as can the colours
  # and styles.
  #
  # @note Refer to UTF-8 U+2500 to U+257F for border characters. More details
  #   can be found at: http://en.wikipedia.org/wiki/Box-drawing_character
  #
  class Border

    include Vedeu::Model

    attr_accessor :attributes,
      :bottom_left,
      :bottom_right,
      :horizontal,
      :show_bottom,
      :show_left,
      :show_right,
      :show_top,
      :top_left,
      :top_right,
      :vertical

    attr_reader :name,
      :colour,
      :enabled,
      :style

    alias_method :enabled?, :enabled
    alias_method :bottom?,  :show_bottom
    alias_method :left?,    :show_left
    alias_method :right?,   :show_right
    alias_method :top?,     :show_top

    # Returns a new instance of Border.
    #
    # @param attributes [Hash]
    # @option attributes bottom_left [String] The bottom left border character.
    # @option attributes bottom_right [String] The bottom right border
    #   character.
    # @option attributes colour
    # @option attributes enabled [Boolean] Indicate whether the border is to be
    #   shown for this interface.
    # @option attributes horizontal [String] The horizontal border character.
    # @option attributes name [String]
    # @option attributes style
    # @option attributes show_bottom [Boolean] Indicate whether the bottom
    #   border is to be shown.
    # @option attributes show_left [Boolean] Indicate whether the left border
    #   is to be shown.
    # @option attributes show_right [Boolean] Indicate whether the right border
    #   is to be shown.
    # @option attributes show_top [Boolean] Indicate whether the top border is
    #   to be shown.
    # @option attributes top_left [String] The top left border character.
    # @option attributes top_right [String] The top right border character.
    # @option attributes vertical [String] The vertical border character.
    # @return [Border]
    def initialize(attributes = {})
      @attributes = defaults.merge(attributes)

      @enabled    = @attributes[:enabled]
      @bottom_left = @attributes[:bottom_left]
      @bottom_right = @attributes[:bottom_right]
      @show_bottom = @attributes[:show_bottom]
      @show_left   = @attributes[:show_left]
      @show_right  = @attributes[:show_right]
      @show_top    = @attributes[:show_top]
      @top_left = @attributes[:top_left]
      @top_right = @attributes[:top_right]
      @horizontal  = @attributes[:horizontal]
      @vertical    = @attributes[:vertical]
      @name       = @attributes[:name]
      @colour     = Colour.coerce(@attributes[:colour])
      @repository = Vedeu.borders
      @style      = Style.coerce(@attributes[:style])
    end

    # Returns the width of the interface determined by whether a left, right,
    # both or neither borders are shown.
    #
    # @return [Fixnum]
    def width
      return interface.width unless enabled?

      if left? && right?
        interface.width - 2

      elsif left? || right?
        interface.width - 1

      else
        interface.width

      end
    end

    # Returns the height of the interface determined by whether a top, bottom,
    # both or neither borders are shown.
    #
    # @return [Fixnum]
    def height
      return interface.height unless enabled?

      if top? && bottom?
        interface.height - 2

      elsif top? || bottom?
        interface.height - 1

      else
        interface.height

      end
    end

    # Set the border colour.
    #
    # @return [Vedeu::Colour]
    def colour=(value)
      @colour = Colour.coerce(value)
    end

    # Set the border style.
    #
    # @return [Vedeu::Style]
    def style=(value)
      @style = Style.coerce(value)
    end

    # Returns a string representation of the border for the interface without
    # content.
    #
    # @return [Boolean]
    def to_s
      render = Vedeu::Viewport.new(interface).render
      render.map { |line| line.flatten.join }.join("\n")
    end

    # Renders the bottom border for the interface.
    #
    # @return [String]
    def bottom
      return [] unless bottom?

      out = []

      out << border(bottom_left, :bottom_left) if left?
      width.times do
        out << border(horizontal, :bottom_horizontal)
      end
      out << border(bottom_right, :bottom_right) if right?

      out.flatten
    end

    # Renders the left border for the interface.
    #
    # @return [String]
    def left
      return [] unless left?

      border(vertical, :left_vertical)
    end

    # Renders the right border for the interface.
    #
    # @return [String]
    def right
      return [] unless right?

      border(vertical, :right_vertical)
    end

    # Renders the top border for the interface.
    #
    # @return [String]
    def top
      return [] unless top?

      out = []
      out << border(top_left, :top_left) if left?
      width.times do
        out << border(horizontal, :top_horizontal)
      end
      out << border(top_right, :top_right) if right?

      out.flatten
    end

    private

    # @param value [String]
    # @param type [Symbol|NilClass]
    # @return [Vedeu::Char]
    def border(value, type = :border)
      Vedeu::Char.new({ value:    value,
                        parent:   interface,
                        colour:   colour,
                        style:    style,
                        position: nil,
                        border:   type })
    end

    # @return [Vedeu::Interface]
    def interface
      @_interface ||= Vedeu.interfaces.find(name)
    end

    # The default values for a new instance of this class.
    #
    # @return [Hash]
    def defaults
      {
        bottom_left:  "\x6D", # └
        bottom_right: "\x6A", # ┘
        client:       nil,
        colour:       {},
        enabled:      false,
        horizontal:   "\x71", # ─
        name:         '',
        show_bottom:  true,
        show_left:    true,
        show_right:   true,
        show_top:     true,
        style:        [],
        top_left:     "\x6C", # ┌
        top_right:    "\x6B", # ┐
        vertical:     "\x78", # │
      }
    end

  end # Border

end # Vedeu
