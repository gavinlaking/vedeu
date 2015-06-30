module Vedeu

  # Provides the mechanism to decorate an interface with a border on all edges,
  # or specific edges. The characters which are used for the border parts (e.g.
  # the corners, verticals and horizontals) can be customised as can the colours
  # and styles.
  #
  # @note Refer to UTF-8 U+2500 to U+257F for border characters. More details
  #   can be found at: http://en.wikipedia.org/wiki/Box-drawing_character
  #
  # @api private
  class Border

    extend Forwardable
    include Vedeu::Common
    include Vedeu::Model
    include Vedeu::Presentation

    def_delegators :geometry,
                   :x,
                   :xn,
                   :y,
                   :yn

    def_delegators :interface, :visible?

    # @!attribute [rw] attributes
    # @return [Hash]
    attr_accessor :attributes

    # @!attribute [rw] bottom_left
    # @return [String]
    attr_accessor :bottom_left

    # @!attribute [rw] bottom_right
    # @return [String]
    attr_accessor :bottom_right

    # @!attribute [rw] horizontal
    # @return [String]
    attr_accessor :horizontal

    # @!attribute [rw] show_bottom
    # @return [Boolean]
    attr_accessor :show_bottom
    alias_method :bottom?, :show_bottom

    # @!attribute [rw] show_left
    # @return [Boolean]
    attr_accessor :show_left
    alias_method :left?, :show_left

    # @!attribute [rw] show_right
    # @return [Boolean]
    attr_accessor :show_right
    alias_method :right?, :show_right

    # @!attribute [rw] show_top
    # @return [Boolean]
    attr_accessor :show_top
    alias_method :top?, :show_top

    # @!attribute [rw] title
    # @return [String]
    attr_accessor :title

    # @!attribute [rw] top_left
    # @return [String]
    attr_accessor :top_left

    # @!attribute [rw] top_right
    # @return [String]
    attr_accessor :top_right

    # @!attribute [rw] vertical
    # @return [String]
    attr_accessor :vertical

    # @!attribute [r] name
    # @return [String]
    attr_reader :name

    # @!attribute [r] enabled
    # @return [Boolean]
    attr_reader :enabled
    alias_method :enabled?, :enabled

    # Returns a new instance of Vedeu::Border.
    #
    # @param attributes [Hash]
    # @option attributes bottom_left [String] The bottom left border character.
    # @option attributes bottom_right [String] The bottom right border
    #   character.
    # @option attributes colour [Hash]
    # @option attributes enabled [Boolean] Indicate whether the border is to be
    #   shown for this interface.
    # @option attributes horizontal [String] The horizontal border character.
    # @option attributes name [String] The name of the interface to which this
    #   border relates.
    # @option attributes style []
    # @option attributes show_bottom [Boolean] Indicate whether the bottom
    #   border is to be shown.
    # @option attributes show_left [Boolean] Indicate whether the left border
    #   is to be shown.
    # @option attributes show_right [Boolean] Indicate whether the right border
    #   is to be shown.
    # @option attributes show_top [Boolean] Indicate whether the top border is
    #   to be shown.
    # @option attributes title [String] A title bar for when the top border is
    #   to be shown.
    # @option attributes top_left [String] The top left border character.
    # @option attributes top_right [String] The top right border character.
    # @option attributes vertical [String] The vertical border character.
    # @return [Border]
    def initialize(attributes = {})
      @attributes   = defaults.merge!(attributes)

      @attributes.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    # @return [Fixnum]
    def bx
      @bx ||= (enabled? && left?) ? x + 1 : x
    end

    # @return [Fixnum]
    def bxn
      @bxn ||= (enabled? && right?) ? xn - 1 : xn
    end

    # @return [Fixnum]
    def by
      @by ||= (enabled? && top?) ? y + 1 : y
    end

    # @return [Fixnum]
    def byn
      @byn ||= (enabled? && bottom?) ? yn - 1 : yn
    end

    # Returns the width of the interface determined by whether a left, right,
    # both or neither borders are shown.
    #
    # @return [Fixnum]
    def width
      (bx..bxn).size
    end

    # Returns the height of the interface determined by whether a top, bottom,
    # both or neither borders are shown.
    #
    # @return [Fixnum]
    def height
      (by..byn).size
    end

    # @return [Array<Array<Vedeu::Char>>]
    def render
      return [] unless visible?
      return [] unless enabled?

      Vedeu.timer("Rendering border: #{name}") do
        out = [top, bottom]

        height.times do |y|
          out << [left(y), right(y)]
        end

        out.flatten
      end
    end

    # @return [String]
    def to_s
      Vedeu::Renderers::Text.render(render)
    end
    alias_method :to_str, :to_s

    # Renders the bottom border for the interface.
    #
    # @return [String]
    def bottom
      return [] unless bottom?

      out = []
      out << border(bottom_left, :bottom_left, *[yn, x]) if left?
      out << horizontal_border(:bottom_horizontal, yn)
      out << border(bottom_right, :bottom_right, *[yn, xn]) if right?
      out
    end

    # Renders the left border for the interface.
    #
    # @param iy [Fixnum]
    # @return [String]
    def left(iy = 0)
      return [] unless left?

      border(vertical, :left_vertical, *[(by + iy), x])
    end

    # Renders the right border for the interface.
    #
    # @param iy [Fixnum]
    # @return [String]
    def right(iy = 0)
      return [] unless right?

      border(vertical, :left_vertical, *[(by + iy), xn])
    end

    # Renders the top border for the interface.
    #
    # @note
    #   If a title has been specified, then the top border will include this
    #   title unless the size of the interface is smaller than the padded title
    #   length.
    #
    # @return [String]
    def top
      return [] unless top?

      out = []
      out << border(top_left, :top_left, *[y, x]) if left?
      if title? && width > title_characters.size
        out << titlebar

      else
        out << horizontal_border(:top_horizontal, y)

      end
      out << border(top_right, :top_right, *[y, xn]) if right?
      out
    end

    # The parent of a border is always an interface.
    #
    # @return [Vedeu::Interface]
    def parent
      interface
    end

    private

    # @param position [Symbol] Either :top_horizontal, or :bottom_horizontal.
    # @return [Array<Vedeu::Char>]
    def horizontal_border(position, y_coordinate)
      width.times.each_with_object([]) do |ix, a|
        a << border(horizontal, position, *[y_coordinate, (bx + ix)])
      end
    end

    # From the second element of {#title_characters} remove the border from each
    # {#horizontal_border} Vedeu::Char, and add the title character.
    #
    # @return [Array<Vedeu::Char>]
    def titlebar
      horizontal_border(:top_horizontal, y).each_with_index do |char, index|
        if index >= 1 && index <= title_characters.size
          char.border = nil
          char.value  = title_characters[(index - 1)]
        end
      end
    end

    # @return [Array<String>]
    def title_characters
      @title_characters ||= padded_title.chars
    end

    # Pads the title with a single whitespace either side.
    #
    # @example
    #   title = 'Truncated!'
    #   width = 20
    #   # => ' Truncated! '
    #
    #   width = 10
    #   # => ' Trunca '
    #
    # @return [String]
    # @see #truncated_title
    def padded_title
      truncated_title.center(truncated_title.size + 2)
    end

    # Truncates the title to the width of the interface, minus characters needed
    # to ensure there is at least a single character of horizontal border and a
    # whitespace on either side of the title.
    #
    # @example
    #   title = 'Truncated!'
    #   width = 20
    #   # => 'Truncated!'
    #
    #   width = 10
    #   # => 'Trunca'
    #
    # @return [String]
    def truncated_title
      title.chomp.slice(0..(width - 5))
    end

    # Return boolean indicating whether this border has a non-empty title.
    #
    # @return [Boolean]
    def title?
      present?(title)
    end

    # @param value [String]
    # @param type [Symbol|NilClass]
    # @param iy [Fixnum]
    # @param ix [Fixnum]
    # @return [Vedeu::Char]
    def border(value, type = :border, iy = 0, ix = 0)
      Vedeu::Char.new(value:    value,
                      parent:   interface,
                      colour:   colour,
                      style:    style,
                      position: Vedeu::Position[iy, ix],
                      border:   type)
    end

    # @return [Vedeu::Geometry]
    def geometry
      Vedeu.geometries.by_name(name)
    end

    # @return [Vedeu::Interface]
    def interface
      @interface ||= Vedeu.interfaces.by_name(name)
    end

    # The default values for a new instance of this class.
    #
    # @note
    #   Using the '\uXXXX' variant produces gaps in the border, whilst the
    #   '\xXX' renders 'nicely'.
    #
    # @return [Hash]
    def defaults
      {
        bottom_left:  "\x6D", # └ # \u2514
        bottom_right: "\x6A", # ┘ # \u2518
        client:       nil,
        colour:       nil,
        enabled:      false,
        horizontal:   "\x71", # ─ # \u2500
        name:         '',
        repository:   Vedeu.borders,
        show_bottom:  true,
        show_left:    true,
        show_right:   true,
        show_top:     true,
        style:        nil,
        title:        '',
        top_left:     "\x6C", # ┌ # \u250C
        top_right:    "\x6B", # ┐ # \u2510
        vertical:     "\x78", # │ # \u2502
      }
    end

  end # Border

end # Vedeu
