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

    # Returns an instance of Viewport.
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
      if border?
        out = []

        out << border.top if border.top?

        show[0...bordered_height].each do |line|
          out << [border.left, line[0...bordered_width], border.right].flatten
        end

        out << border.bottom if border.bottom?

        out

      else
        show

      end
    end

    # Returns a string representation of the viewport.
    #
    # @return [String]
    def to_s
      render.map(&:join).join("\n")
    end

    private

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

      line_pad.map { |line| column_pad(line) }.compact
    end

    # Pad the number of rows so that we always return an Array of the same
    # length for each viewport.
    #
    # @return [Array<Array<String>>]
    def line_pad
      visible_lines = lines[rows] || []

      if visible_lines.size < height
        visible_lines + [" "] * (height - visible_lines.size)

      else
        visible_lines

      end
    end

    # Pads the number of columns so that we always return an Array of the same
    # length for each line.
    #
    # @param line [Array<String>]
    # @return [Array<String>]
    def column_pad(line)
      visible_columns = line.chars[columns] || []

      if visible_columns.size < width
        visible_columns + [" "] * (width - visible_columns.size)

      else
        visible_columns

      end
    end

    # Using the current cursor's x position, return a range of visible lines.
    #
    # Scrolls the content horizontally when the stored cursor's x position for
    # the interface is outside of the visible area.
    #
    # @note
    #   [value, 0].max # this allows us to set a left that is greater
    #                  # than the content width.
    #
    #   [[value, (content_width - width)].min, 0].max
    #                  # this does not allow us to have a position
    #                  # greater than the content width.
    #
    # @return [Range]
    def rows
      top = if oy >= bordered_height
        [(oy - bordered_height), 0].max

      else
        0

      end

      top..(top + (height - 1))
    end

    # Using the current cursor's y position, return a range of visible columns.
    #
    # Scrolls the content vertically when the stored cursor's y position for the
    # interface is outside of the visible area.
    #
    # @note
    #   [value, 0].max # this allows us to set a top that is greater than
    #                  # the content height.
    #
    #   [[value, (content_height - height)].min, 0].max
    #                  # this does not allow us to have a position
    #                  # greater than the content height.
    #
    # @return [Range]
    def columns
      left = if ox >= bordered_width
        [(ox - bordered_width), 0].max

      else
        0

      end

      left..(left + (width - 1))
    end

    # @return [Fixnum]
    def bordered_width
      return border.width if border?

      width
    end

    # @return [Fixnum]
    def bordered_height
      return border.height if border?

      height
    end

    # @return [Vedeu::Border]
    def border
      @_border ||= Vedeu.borders.find(interface.name)
    end

    # @return [Boolean]
    def border?
      Vedeu.borders.registered?(interface.name)
    end

  end # Viewport

end # Vedeu
