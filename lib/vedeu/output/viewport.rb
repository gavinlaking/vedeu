module Vedeu

  # A Viewport is the visible part of the content within an interface.
  #
  # When a buffer has more lines than the defined height, or more columns than
  # the defined width of the interface, the Viewport class provides 'scrolling'
  # via the cursor's position.
  #
  class Viewport

    # @see Viewport#show
    def self.show(interface)
      new(interface).show
    end

    # Returns an instance of Viewport.
    #
    # @param interface [Interface] An instance of interface.
    # @return [Viewport]
    def initialize(interface)
      @interface = interface
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

    attr_reader :interface

    def line_pad
      cl = content[lines] || []
      if cl.size < height
        cl + [" "] * (height - cl.size)
      else
        cl
      end
    end

    def column_pad(line)
      chars = line.chars[columns] || [" "]
      if chars.size < width
        chars + [" "] * (width - chars.size)
      else
        chars
      end
    end

    # Scrolls the content vertically when the stored y offset for the interface
    # is outside of the visible area.
    #
    # @note
    #   @top = [value, 0].max # this allows us to set a top that is greater than
    #                         # the content height.
    #
    #   @top = [[value, (content_height - height)].min, 0].max
    #                         # this does not allow us to have an offset greater
    #                         # than the content height.
    #
    # @return [Fixnum]
    def line_adjustment
      if offset.y < 0
        @top = [offset.y, 0].max

      elsif offset.y > height
        @top = [(offset.y - height), 0].max

      end
    end

    # Scrolls the content horizontally when the stored x offset for the
    # interface is outside of the visible area.
    #
    # @note
    #   @left = [value, 0].max # this allows us to set a left that is greater
    #                          # than the content width.
    #
    #   @left = [[value, (content_width - width)].min, 0].max
    #                         # this does not allow us to have an offset greater
    #                         # than the content width.
    #
    # @return [Fixnum]
    def column_adjustment
      if offset.x < 0
        @left = [offset.x, 0].max

      elsif offset.x > width
        @left = [(offset.x - width), 0].max

      end
    end

    # Using the current x offset, return a range of visible lines.
    #
    # @return [Range]
    def lines
      @top..(@top + height)
    end

    # Using the current y offset, return a range of visible columns.
    #
    # @return [Range]
    def columns
      @left..(@left + width)
    end

    # Returns the height of the content, or when no content, the visible height
    # of the interface.
    #
    # @return [Fixnum]
    def content_height
      return height unless content?

      [content.size, height].max
    end

    # Returns the width of the content, or when no content, the visible width of
    # the interface.
    #
    # @return [Fixnum]
    def content_width
      return width unless content?

      [content_maximum_line_length, width].max
    end

    # Returns the character length of the longest line for this interface.
    #
    # @return [Fixnum]
    def content_maximum_line_length
      content.map { |line| line.size }.max
    end

    # Return a boolean indicating whether this interface currently has content.
    #
    # @return [Boolean]
    def content?
      content.any?
    end

    def content
      interface.content
    end

    def offset
      interface.offset
    end

    def width
      interface.width - 1
    end

    def height
      interface.height - 1
    end

  end # Viewport

end # Vedeu
