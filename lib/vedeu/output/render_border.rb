module Vedeu

  # Renders the provided border.
  #
  # @api private
  class RenderBorder

    extend Forwardable
    include Vedeu::Common

    def_delegators :border,
                   :bottom?,
                   :bottom_left,
                   :bottom_right,
                   :bx,
                   :bxn,
                   :by,
                   :byn,
                   :colour,
                   :enabled?,
                   :height,
                   :horizontal,
                   :left?,
                   :name,
                   :right?,
                   :style,
                   :title,
                   :top?,
                   :top_left,
                   :top_right,
                   :width,
                   :vertical

    def_delegators :geometry,
                   :x,
                   :xn,
                   :y,
                   :yn

    # @return [Array<Array<Vedeu::Char>>]
    # @see Vedeu::RenderBorder#initialize
    def self.with(border)
      new(border).render
    end

    # Returns a new instance of Vedeu::RenderBorder.
    #
    # @param border [Vedeu::Border]
    # @return [Vedeu::Renderers::Border]
    def initialize(border)
      @border = border
    end

    # @return [Array<Array<Vedeu::Char>>]
    def render
      return [] unless interface.visible?
      return [] unless enabled?

      Vedeu.timer("Rendering border: #{name}") do
        out = [top, bottom]

        height.times { |y| out << [left(y), right(y)] }

        out.flatten
      end
    end

    protected

    # @!attribute [r] border
    # @return [Vedeu::Border]
    attr_reader :border

    private

    # @param value [String]
    # @param type [Symbol|NilClass]
    # @param iy [Fixnum]
    # @param ix [Fixnum]
    # @return [Vedeu::Char]
    def build(value, type = :border, iy = 0, ix = 0)
      Vedeu::Char.new(value:    value,
                      parent:   interface,
                      colour:   colour,
                      style:    style,
                      position: [iy, ix],
                      border:   type)
    end

    # @return [Vedeu::Char]
    def build_bottom_left
      build(bottom_left, :bottom_left, *[yn, x]) if left?
    end

    # @return [Vedeu::Char]
    def build_bottom_right
      build(bottom_right, :bottom_right, *[yn, xn]) if right?
    end

    # @return [Vedeu::Char]
    def build_top_left
      build(top_left, :top_left, *[y, x]) if left?
    end

    # @return [Vedeu::Char]
    def build_top_right
      build(top_right, :top_right, *[y, xn]) if right?
    end

    # Renders the bottom border for the interface.
    #
    # @return [String]
    def bottom
      return [] unless bottom?

      [
        build_bottom_left,
        build_horizontal(:bottom_horizontal, yn),
        build_bottom_right,
      ].compact
    end

    # @return [Vedeu::Geometry]
    def geometry
      Vedeu.geometries.by_name(name)
    end

    # @param position [Symbol] Either :top_horizontal, or :bottom_horizontal.
    # @param y_coordinate [Fixnum] The value of either y or yn.
    # @return [Array<Vedeu::Char>]
    def build_horizontal(position, y_coordinate)
      Array.new(width) do |ix|
        build(horizontal, position, *[y_coordinate, (bx + ix)])
      end
    end

    # The parent of a border is always an interface.
    #
    # @return [Vedeu::Interface]
    def interface
      @interface ||= Vedeu.interfaces.by_name(name)
    end
    alias_method :parent, :interface

    # Renders the left border for the interface.
    #
    # @param iy [Fixnum]
    # @return [String]
    def left(iy = 0)
      return [] unless left?

      build(vertical, :left_vertical, *[(by + iy), x])
    end

    # Renders the right border for the interface.
    #
    # @param iy [Fixnum]
    # @return [String]
    def right(iy = 0)
      return [] unless right?

      build(vertical, :right_vertical, *[(by + iy), xn])
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

      [build_top_left, titlebar, build_top_right].compact
    end

    # From the second element of {#title_characters} remove the border from each
    # {#horizontal_border} Vedeu::Char, and add the title character.
    #
    # @return [Array<Vedeu::Char>]
    def titlebar
      return build_horizontal(:top_horizontal, y) unless title? && title_fits?

      build_horizontal(:top_horizontal, y).each_with_index do |char, index|
        if index >= 1 && index <= title_characters.size
          char.border = nil
          char.value  = title_characters[(index - 1)]
        end
      end
    end

    # Return boolean indicating whether this border has a non-empty title.
    #
    # @return [Boolean]
    def title?
      present?(title)
    end

    # Return boolean indicating whether the title fits within the width of the
    # top border.
    #
    # @return [Boolean]
    def title_fits?
      width > title_characters.size
    end

    # @return [Array<String>]
    def title_characters
      @title_characters ||= title_padded.chars
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
    def title_padded
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

  end # RenderBorder

end # Vedeu
