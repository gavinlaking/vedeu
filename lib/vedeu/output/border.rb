require 'vedeu/repositories/all'
require 'vedeu/dsl/components/all'

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

    include Vedeu::Common
    include Vedeu::Model

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

    # @!attribute [r] colour
    # @return [Vedeu::Colour]
    attr_reader :colour

    # @!attribute [r] enabled
    # @return [Boolean]
    attr_reader :enabled
    alias_method :enabled?, :enabled

    # @!attribute [r] style
    # @return [Style]
    attr_reader :style

    # Returns a new instance of Vedeu::Border.
    #
    # @param attributes [Hash]
    # @option attributes bottom_left [String] The bottom left border character.
    # @option attributes bottom_right [String] The bottom right border
    #   character.
    # @option attributes colour []
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
      @enabled      = @attributes[:enabled]
      @bottom_left  = @attributes[:bottom_left]
      @bottom_right = @attributes[:bottom_right]
      @show_bottom  = @attributes[:show_bottom]
      @show_left    = @attributes[:show_left]
      @show_right   = @attributes[:show_right]
      @show_top     = @attributes[:show_top]
      @title        = @attributes[:title]
      @top_left     = @attributes[:top_left]
      @top_right    = @attributes[:top_right]
      @horizontal   = @attributes[:horizontal]
      @vertical     = @attributes[:vertical]
      @name         = @attributes[:name]
      @colour       = @attributes[:colour]
      @repository   = Vedeu.borders
      @style        = @attributes[:style]
    end

    # @return [Fixnum]
    def bx
      if enabled? && left?
        interface.x + 1

      else
        interface.x

      end
    end

    # @return [Fixnum]
    def bxn
      if enabled? && right?
        interface.xn - 1

      else
        interface.xn

      end
    end

    # @return [Fixnum]
    def by
      if enabled? && top?
        interface.y + 1

      else
        interface.y

      end
    end

    # @return [Fixnum]
    def byn
      if enabled? && bottom?
        interface.yn - 1

      else
        interface.yn

      end
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

    # @return [Vedeu::Colour]
    def colour
      Vedeu::Colour.coerce(@colour)
    end

    # Set the border colour.
    #
    # @return [Vedeu::Colour]
    def colour=(value)
      @colour = Vedeu::Colour.coerce(value)
    end

    # @return [Array<Array<Vedeu::Char>>]
    def render
      return [] unless enabled?

      out = [top, bottom]

      height.times do |y|
        out << [left(y), right(y)]
      end

      out.flatten
    end

    # @return [Vedeu::Style]
    def style
      Vedeu::Style.coerce(@style)
    end

    # Set the border style.
    #
    # @return [Vedeu::Style]
    def style=(value)
      @style = Vedeu::Style.coerce(value)
    end

    # Renders the bottom border for the interface.
    #
    # @return [String]
    def bottom
      top_or_bottom('bottom')
    end

    # Renders the left border for the interface.
    #
    # @param iy [Fixnum]
    # @return [String]
    def left(iy = 0)
      return [] unless left?

      border(vertical, :left_vertical, iy)
    end

    # Renders the right border for the interface.
    #
    # @param iy [Fixnum]
    # @return [String]
    def right(iy = 0)
      return [] unless right?

      border(vertical, :right_vertical, iy)
    end

    # Renders the top border for the interface.
    #
    # @return [String]
    def top
      top_or_bottom('top')
    end

    private

    # @param prefix [String]
    # @return [String]
    def top_or_bottom(prefix)
      predicate   = (prefix + '?').to_sym
      _left       = (prefix + '_left').to_sym
      _right      = (prefix + '_right').to_sym
      _horizontal = (prefix + '_horizontal').to_sym

      return [] unless send(predicate)

      out = []
      out << border(send(_left), _left) if left?
      width.times do |ix|
        out << border(horizontal, _horizontal, nil, ix)
        # out << titleize
      end
      out << border(send(_right), _right) if right?
    end

    # @param value [String]
    # @param type [Symbol|NilClass]
    # @param iy [Fixnum]
    # @param ix [Fixnum]
    # @return [Vedeu::Char]
    def border(value, type = :border, iy = 0, ix = 0)
      Vedeu::Char.new({ value:    value,
                        parent:   interface,
                        colour:   colour,
                        style:    style,
                        position: position(type, iy, ix),
                        border:   type })
    end

    def titleize
      out = []

      if defined_value?(title)
        truncated_title = title.chomp.slice(0..(width - 3))
        border_chars    = width - truncated_title.size

        out << border(horizontal, :top_horizontal, nil, 0)
        out << border(horizontal, :top_horizontal, nil, 1)
        [' ', truncated_title.chars, ' '].flatten.each_with_index do |char, ix|
          out << border(char, :none, nil, (ix + 2))
        end
        out << border_chars.times { out << border(horizontal, :top_horizontal) }

      else
        width.times { out << border(horizontal, :top_horizontal) }

      end

      out
    end

    # @return [Vedeu::Interface]
    def interface
      @interface ||= Vedeu.interfaces.find(name)
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
        title:        '',
        top_left:     "\x6C", # ┌
        top_right:    "\x6B", # ┐
        vertical:     "\x78", # │
      }
    end

    # @return [Vedeu::Interface]
    def interface
      @interface ||= Vedeu.interfaces.find(name)
    end

    # @param name [Symbol]
    # @param iy [Fixnum]
    # @param ix [Fixnum]
    # @return [Vedeu::Position]
    def position(name, iy = 0, ix = 0)
      case name
      when :top_horizontal
        Vedeu::Position[interface.y, (bx + ix)]

      when :bottom_horizontal
        Vedeu::Position[interface.yn, (bx + ix)]

      when :left_vertical
        Vedeu::Position[(by + iy), interface.x]

      when :right_vertical
        Vedeu::Position[(by + iy), interface.xn]

      when :bottom_left  then interface.bottom_left
      when :bottom_right then interface.bottom_right
      when :top_left     then interface.top_left
      when :top_right    then interface.top_right
      else
        nil

      end
    end

  end # Border

end # Vedeu
