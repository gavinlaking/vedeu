require 'vedeu/dsl/border'

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

    attr_accessor :attributes

    def self.build(interface, attributes = {}, &block)
      model = self.new(interface, attributes)
      model.deputy.instance_eval(&block) if block_given?
      model
    end

    # Returns a new instance of Border.
    #
    # @param interface [Interface]
    # @param attributes [Hash]
    # @return [Border]
    def initialize(interface, attributes = {})
      @interface  = interface
      @attributes = defaults.merge(attributes)
      @colour     = Colour.coerce(@attributes[:colour])
      @style      = Style.coerce(@attributes[:style])
    end

    # Returns the interface with border (if enabled) and the content for the
    # interface.
    #
    # @return [Array<Array<String>>]
    def render
      out = []

      out << top if top?

      interface.viewport[0...height].each do |line|
        out << [left, line[0...width], right].flatten
      end

      out << bottom if bottom?

      out
    end

    # Set the border colour.
    #
    # @return []
    def colour=(value)
      @colour = Colour.coerce(value)
    end

    # Set the border style.
    #
    # @return []
    def style=(value)
      @style = Style.coerce(value)
    end

    # Returns a boolean indicating whether the border is to be shown for this
    # interface.
    #
    # @return [Boolean]
    def enabled?
      attributes[:enabled]
    end

    # Returns a boolean indicating whether the bottom border is to be shown.
    #
    # @return [Boolean]
    def bottom?
      attributes[:show_bottom]
    end

    # Returns a boolean indicating whether the left border is to be shown.
    #
    # @return [Boolean]
    def left?
      attributes[:show_left]
    end

    # Returns a boolean indicating whether the right border is to be shown.
    #
    # @return [Boolean]
    def right?
      attributes[:show_right]
    end

    # Returns a boolean indicating whether the top border is to be shown.
    #
    # @return [Boolean]
    def top?
      attributes[:show_top]
    end

    # Returns a string representation of the border for the interface without
    # content.
    #
    # @return [Boolean]
    def to_s
      render.map { |line| line.flatten.join }.join("\n")
    end

    private

    attr_reader :colour, :interface, :style

    # Renders the bottom border for the interface.
    #
    # @return [String]
    def bottom
      return [] unless bottom?

      out = []

      out << bottom_left
      horizontal_border.each do |border|
        out << border
      end
      out << bottom_right

      out
    end

    # Renders the left border for the interface.
    #
    # @return [String]
    def left
      return '' unless left?

      vertical_border
    end

    # Renders the right border for the interface.
    #
    # @return [String]
    def right
      return '' unless right?

      vertical_border
    end

    # Renders the top border for the interface.
    #
    # @return [String]
    def top
      return [] unless top?

      out = []
      out << top_left
      horizontal_border.each do |border|
        out << border
      end
      out << top_right

      out
    end

    # Renders the bottom left border character with escape codes for colour and
    # style for the interface.
    #
    # @return [String]
    def bottom_left
      return '' unless left?

      [*presentation, on, bl, off, *reset].join
    end

    # Renders the bottom right border character with escape codes for colour and
    # style for the interface.
    #
    # @return [String]
    def bottom_right
      return '' unless right?

      [*presentation, on, br, off, *reset].join
    end

    # Renders the top left border character with escape codes for colour and
    # style for the interface.
    #
    # @return [String]
    def top_left
      return '' unless left?

      [*presentation, on, tl, off, *reset].join
    end

    # Renders the top right border character with escape codes for colour and
    # style for the interface.
    #
    # @return [String]
    def top_right
      return '' unless right?

      [*presentation, on, tr, off, *reset].join
    end

    # Returns the width of the interface determined by whether a left, right,
    # both or neither borders are shown.
    #
    # @return [Fixnum]
    def width
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
      if top? && bottom?
        interface.height - 2

      elsif top? || bottom?
        interface.height - 1

      else
        interface.height

      end
    end

    # Returns the horizontal border characters with colours and styles.
    #
    # @return [Array<String>]
    def horizontal_border
      [[*presentation, on, h, off, *reset].join] * width
    end

    # Returns the vertical border characters with colours and styles.
    #
    # @return [String]
    def vertical_border
      [*presentation, on, v, off, *reset].join
    end

    # Returns the horizontal border character.
    #
    # @return [String]
    def h
      attributes[:horizontal]
    end

    # Returns the vertical border character.
    #
    # @return [String]
    def v
      attributes[:vertical]
    end

    # Returns the top right border character.
    #
    # @return [String]
    def tr
      attributes[:top_right]
    end

    # Returns the top left border character.
    #
    # @return [String]
    def tl
      attributes[:top_left]
    end

    # Returns the bottom right border character.
    #
    # @return [String]
    def br
      attributes[:bottom_right]
    end

    # Returns the bottom left border character.
    #
    # @return [String]
    def bl
      attributes[:bottom_left]
    end

    # Returns the escape sequence to start a border.
    #
    # @return [String]
    def on
      "\e(0"
    end

    # Returns the escape sequence to end a border.
    #
    # @return [String]
    def off
      "\e(B"
    end

    # Returns the colour and styles for the border.
    #
    # @return [Array]
    def presentation
      [colour, style]
    end

    # Returns the colour and styles for the interface; effectively turning off
    # the colours and styles for the border.
    #
    # @return [Array]
    def reset
      [interface.colour, interface.style]
    end

    # The default values for a new instance of Border.
    #
    # @return [Hash]
    def defaults
      {
        enabled:      false,
        show_bottom:  true,
        show_left:    true,
        show_right:   true,
        show_top:     true,
        bottom_right: "\x6A", # ┘
        top_right:    "\x6B", # ┐
        top_left:     "\x6C", # ┌
        bottom_left:  "\x6D", # └
        horizontal:   "\x71", # ─
        colour:       {},
        style:        [],
        vertical:     "\x78", # │
      }
    end

  end # Border

end # Vedeu
