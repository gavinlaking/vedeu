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
                   :lines,
                   :lines?,
                   :name,
                   :visible?

    def_delegators :border,
                   :height,
                   :width

    def_delegators :cursor,
                   :ox,
                   :oy

    # @param interface [Vedeu::Interface]
    # @return [Array<Array<Vedeu::Char>>]
    def self.render(interface)
      if interface.visible?
        new(interface).render

      else
        []

      end
    end

    # Returns an instance of Vedeu::Viewport.
    #
    # @param interface [Vedeu::Interface] An instance of interface.
    # @return [Viewport]
    def initialize(interface)
      @interface = interface
    end

    # Returns the interface with border (when enabled) and the content for the
    # interface.
    #
    # @return [Array<Array<String>>]
    def render
      return [] unless visible?

      Vedeu.timer("Rendering: '#{name}'") do
        out = []

        show.each_with_index do |line, iy|
          line.each_with_index do |column, ix|
            column.position = [by + iy, bx + ix]
            out << column
          end
        end

        out
      end
    end

    # Returns a string representation of the viewport.
    #
    # @return [String]
    def to_s
      render.map(&:to_s).join("\n")
    end
    alias_method :to_str, :to_s

    protected

    # @!attribute [r] interface
    # @return [Vedeu::Interface]
    attr_reader :interface

    private

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
      top...(top + height)
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
      left...(left + width)
    end

    # @return [Fixnum]
    def left
      @left ||= content_offset(ox, width)
    end

    # @return [Fixnum]
    def top
      @top ||= content_offset(oy, height)
    end

    # Returns the offset for the content (the number of rows or columns to
    # change the viewport by on either the y or x axis) determined by the offset
    # (the cursor's y or x offset position.
    #
    # @param offset [Fixnum] The cursor's oy or ox values.
    # @param dimension [Fixnum] Either the height or width.
    # @return [Fixnum]
    def content_offset(offset, dimension)
      if offset >= dimension && ((offset - dimension) > 0)
        offset - dimension

      else
        0

      end
    end

    # Return the border associated with the interface we are drawing.
    #
    # @return (see Vedeu::Borders#by_name)
    def border
      @border ||= Vedeu.borders.by_name(name)
    end

    # @return [Fixnum]
    def bx
      @bx ||= border.bx
    end

    # @return [Fixnum]
    def by
      @by ||= border.by
    end

    # Fetch the cursor associated with the interface we are drawing.
    #
    # @return (see Vedeu::Cursors#by_name)
    def cursor
      @cursor ||= Vedeu.cursors.by_name(name)
    end

  end # Viewport

end # Vedeu
