module Vedeu

  # A Viewport is the visible part of the content within an interface.
  #
  # When a buffer has more lines than the defined height, or more columns than
  # the defined width of the interface, the Viewport class provides 'scrolling'
  # via the cursor's position.
  #
  class Viewport

    extend Forwardable

    def_delegators :interface, :content, :content?, :cursor, :height, :width

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

    # Pad the number of rows so that we always return an Array of the same
    # length for each viewport.
    #
    # @return [Array<Array<String>>]
    def line_pad
      rows = content[lines] || []

      if rows.size < height
        rows + [" "] * (height - rows.size)

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

      if stream.size < width
        stream + [" "] * (width - stream.size)

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
      if cursor.oy < 0
        @top = 0

      elsif cursor.oy >= bordered_height
        @top = [(cursor.oy - bordered_height), 0].max

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
      if cursor.ox < 0
        @left = 0

      elsif cursor.ox >= bordered_width
        @left = [(cursor.ox - bordered_width), 0].max

      end
    end

    def bordered_width
      return width unless interface.border?

      if interface.border.left? && interface.border.right?
        width - 2
      elsif interface.border.left? || interface.border.right?
        width - 1
      else
        width
      end
    end

    def bordered_height
      return height unless interface.border?

      if interface.border.top? && interface.border.bottom?
        height - 2
      elsif interface.border.top? || interface.border.bottom?
        height - 1
      else
        height
      end
    end

    # Using the current cursor's x position, return a range of visible lines.
    #
    # @return [Range]
    def lines
      @top..(@top + (height - 1))
    end

    # Using the current cursor's y position, return a range of visible columns.
    #
    # @return [Range]
    def columns
      @left..(@left + (width - 1))
    end

  end # Viewport

end # Vedeu
