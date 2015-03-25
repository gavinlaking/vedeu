module Vedeu

  # A Viewport is the visible part of the content within an interface.
  #
  # When a buffer has more lines than the defined height, or more columns than
  # the defined width of the interface, the Viewport class provides 'scrolling'
  # via the cursor's position.
  #
  class Viewport

    extend Forwardable

    def_delegators :interface,
      :geometry,
      :lines,
      :lines?,
      :cursor

    def_delegators :cursor,
      :ox,
      :oy

    def_delegators :geometry,
      :height,
      :width

    # @param interface [Vedeu::Interface]
    # @return [Array<Array<Vedeu::Char>>]
    def self.render(interface)
      new(interface).render
    end

    # Returns an instance of Vedeu::Viewport.
    #
    # @param interface [Interface] An instance of interface.
    # @return [Viewport]
    def initialize(interface)
      @interface = interface
    end

    # Returns the interface with border (if enabled) and the content for the
    # interface.
    #
    # @return [Array<Array<String>>]
    def render
      Vedeu.log(type: :output, message: "Rendering: '#{interface.name}'")

      out = []

      show[0...bordered_height].each_with_index do |line, iy|
        line[0...bordered_width].each_with_index do |column, ix|
          column.position = IndexPosition[iy,
                                          ix,
                                          interface.border.by,
                                          interface.border.bx]
          out << column
        end
      end

      out
    end

    # Returns a string representation of the viewport.
    #
    # @return [String]
    def to_s
      render.map(&:to_s).join("\n")
    end

    private

    # @!attribute [r] interface
    # @return [Vedeu::Interface]
    attr_reader :interface

    # Returns the visible content for the interface.
    #
    # @note If there are no lines of content, we return an empty array. If there
    #   are no more columns of content we return a space enclosed in an array;
    #   this prevents a weird line hopping bug which occurs when the current
    #   line has no more content, but subsequent lines do.
    #
    # @return [Array]
    def show
      return [] unless lines?

      (lines[rows] || []).map { |line| (line.chars[columns] || []) }
    end

    # Using the current cursor's y position, return a range of visible lines.
    #
    # Scrolls the content vertically when the stored cursor's y position for the
    # interface is outside of the visible area.
    #
    # @note
    #   The height is reduced by one as #rows is a range of Array elements.
    #
    # @return [Range]
    def rows
      top..(top + (height - 1))
    end

    # Using the current cursor's x position, return a range of visible columns.
    #
    # Scrolls the content horizontally when the stored cursor's x position for
    # the interface is outside of the visible area.
    #
    # @note
    #   The width is reduced by one as #columns is a range of Array elements.
    #
    # @return [Range]
    def columns
      left..(left + (width - 1))
    end

    # Returns the offset for the content based on the offset.
    #
    # @return [Fixnum]
    def left
      @left ||= reposition_x? ? reposition_x : 0
    end

    # Returns the offset for the content based on the offset.
    #
    # @return [Fixnum]
    def top
      @top ||= reposition_y? ? reposition_y : 0
    end

    # Returns a boolean indicating whether the x offset is greater than or equal
    # to the bordered width.
    #
    # @return [Boolean]
    def reposition_x?
      ox >= bordered_width
    end

    # Returns a boolean indicating whether the y offset is greater than or equal
    # to the bordered height.
    #
    # @return [Boolean]
    def reposition_y?
      oy >= bordered_height
    end

    # Returns the number of columns to change the viewport by on the x axis,
    # determined by the position of the x offset.
    #
    # @return [Fixnum]
    def reposition_x
      ((ox - bordered_width) <= 0) ? 0 : (ox - bordered_width)
    end

    # Returns the number of rows to change the viewport by on the y axis,
    # determined by the position of the y offset.
    #
    # @return [Fixnum]
    def reposition_y
      ((oy - bordered_height) <= 0) ? 0 : (oy - bordered_height)
    end

    # When the viewport has a border, we need to account for that in our
    # redrawing.
    #
    # @return [Fixnum]
    def bordered_width
      return border.width if border?

      width
    end

    # When the viewport has a border, we need to account for that in our
    # redrawing.
    #
    # @return [Fixnum]
    def bordered_height
      return border.height if border?

      height
    end

    # Return the border associated with the interface we are drawing.
    #
    # @return [Vedeu::Border]
    def border
      @border ||= Vedeu.borders.find(interface.name)
    end

    # Returns a boolean indicating the interface we are drawing has a border.
    #
    # @return [Boolean]
    def border?
      Vedeu.borders.registered?(interface.name)
    end

  end # Viewport

end # Vedeu
