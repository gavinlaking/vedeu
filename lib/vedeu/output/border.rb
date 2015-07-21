require 'vedeu/output/render_border'

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
    attr_accessor :enabled
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
    # @option attributes style [Vedeu::Style]
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
    # @return [Vedeu::Border]
    def initialize(attributes = {})
      @attributes   = defaults.merge!(attributes)

      @attributes.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    # @return [Fixnum]
    def bx
      (enabled? && left?) ? x + 1 : x
    end

    # @return [Fixnum]
    def bxn
      (enabled? && right?) ? xn - 1 : xn
    end

    # @return [Fixnum]
    def by
      (enabled? && top?) ? y + 1 : y
    end

    # @return [Fixnum]
    def byn
      (enabled? && bottom?) ? yn - 1 : yn
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
      Vedeu::RenderBorder.with(self)
    end

    private

    # @return [Vedeu::Geometry]
    def geometry
      Vedeu.geometries.by_name(name)
    end

    # @return [Vedeu::Interface]
    def interface
      @interface ||= Vedeu.interfaces.by_name(name)
    end
    alias_method :parent, :interface

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
