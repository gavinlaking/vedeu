module Vedeu

  # A Viewport is the visible part of the content within an interface.
  #
  # When a buffer has more lines than the defined height, or more columns than
  # the defined width of the interface, the Viewport class provides 'scrolling'
  # via the cursor's position.
  #
  class Viewport

    # @see Viewport#show
    def self.show(interface, cursor)
      new(interface, cursor).show
    end

    # Returns an instance of Viewport.
    #
    # @param interface [Interface] An instance of interface.
    # @param cursor [Cursor]
    # @return [Viewport]
    def initialize(interface, cursor)
      @interface = interface
      @cursor    = cursor
      @top       = 0
      @left      = 0
    end

    # Returns the visible content for the interface.
    #
    # @note If there are no lines of content, we return an empty array. If there
    #   are no more columns of content we return a space enclosed in an array;
    #   this prevents a weird line hopping bug which occurs when the current
    #   line has no more content, but subsequent lines do.
    #
    # @return [Array]
    def show
      line_adjustment
      column_adjustment

      return [] unless content?

      line_pad.map { |line| column_pad(line) }.compact
    end

    private

    attr_reader :interface, :cursor

    # Pad the number of rows so that we always return an Array of the same
    # length for each viewport.
    #
    # @return [Array<Array<String>>]
    def line_pad
      rows = content[lines] || []

      if rows.size < (height + 1)
        rows + [" "] * ((height + 1) - rows.size)

      else
        rows

      end
    end

    # Pads the number of columns so that we always return an Array of the same
    # length for each line.
    #
    # @param line [Array<String>]
    # @return [Array<String>]
    def column_pad(line)
      stream = line.chars[columns] || [" "]

      if stream.size < (width + 1)
        stream + [" "] * ((width + 1) - stream.size)

      else
        stream

      end
    end

    # Scrolls the content vertically when the stored cursor's y position for the
    # interface is outside of the visible area.
    #
    # @note
    #   @top = [value, 0].max # this allows us to set a top that is greater than
    #                         # the content height.
    #
    #   @top = [[value, (content_height - height)].min, 0].max
    #                         # this does not allow us to have a position
    #                         # greater than the content height.
    #
    # @return [Fixnum]
    def line_adjustment
      if cursor.y < 0
        @top = [cursor.y, 0].max

      elsif cursor.y > height
        @top = [(cursor.y - height), 0].max

      end
    end

    # Scrolls the content horizontally when the stored cursor's x position for
    # the interface is outside of the visible area.
    #
    # @note
    #   @left = [value, 0].max # this allows us to set a left that is greater
    #                          # than the content width.
    #
    #   @left = [[value, (content_width - width)].min, 0].max
    #                         # this does not allow us to have a position
    #                         # greater than the content width.
    #
    # @return [Fixnum]
    def column_adjustment
      if cursor.x < 0
        @left = [cursor.x, 0].max

      elsif cursor.x > width
        @left = [(cursor.x - width), 0].max

      end
    end

    # Using the current cursor's x position, return a range of visible lines.
    #
    # @return [Range]
    def lines
      @top..(@top + height)
    end

    # Using the current cursor's y position, return a range of visible columns.
    #
    # @return [Range]
    def columns
      @left..(@left + width)
    end

    # Returns the height of the content, or when no content, the visible height
    # of the interface.
    #
    # @note This method is not used at the moment as the interface content area
    #   is made infinite by the cursors last known position.
    #
    # @return [Fixnum]
    # :nocov:
    def content_height
      return height unless content?

      [content.size, height].max
    end
    # :nocov:

    # Returns the width of the content, or when no content, the visible width of
    # the interface.
    #
    # @note This method is not used at the moment as the interface content area
    #   is made infinite by the cursors last known position.
    #
    # @return [Fixnum]
    # :nocov:
    def content_width
      return width unless content?

      [content_maximum_line_length, width].max
    end
    # :nocov:

    # Returns the character length of the longest line for this interface.
    #
    # @note This method is not used at the moment as the interface content area
    #   is made infinite by the cursors last known position.
    #
    # @return [Fixnum]
    # :nocov:
    def content_maximum_line_length
      content.map { |line| line.size }.max
    end
    # :nocov:

    # Return a boolean indicating whether this interface currently has content.
    #
    # @return [Boolean]
    def content?
      content.any?
    end

    # Return the content of the interface.
    #
    # @return [Array<Line>]
    def content
      interface.content
    end

    # Return the width of the interface for a zero-indexed array.
    #
    # @return [Fixnum]
    def width
      interface.width - 1
    end

    # Return the height of the interface for a zero-indexed array.
    #
    # @return [Fixnum]
    def height
      interface.height - 1
    end

  end # Viewport

end # Vedeu
