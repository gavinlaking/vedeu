module Vedeu

  # A Viewport is the visible part of the content within an interface.
  #
  # When a buffer has more lines than the defined height, or more columns than
  # the defined width of the interface, the Viewport class provides 'scrolling'
  # via the cursor's position.
  #
  class Viewport

    extend Forwardable

    def_delegators :interface, :content, :height, :offset, :width

    # @param interface [Interface] An instance of interface.
    # @return [Viewport]
    def initialize(interface)
      @interface = interface
      @top       = 0
      @left      = 0
    end

    # @return [Cursor]
    def cursor
      area   = Area.from_interface(interface)
      curs_x = area.x_position(offset.x)
      curs_y = area.y_position(offset.y)

      Cursor.new({ name: interface.name, y: curs_y, x: curs_x }).to_s
    end

    # @return [Array]
    def visible_content
      set_position

      return [] unless content?

      content[lines].map { |line| line.chars[columns] }.compact
    end

    private

    attr_reader :interface

    # @return [Fixnum]
    def set_position
      line_adjustment
      column_adjustment
    end

    # @return [Fixnum]
    def line_adjustment
      if offset.y < lines.min
        set_top(offset.y)

      elsif offset.y > lines.max
        new_top = offset.y - (lines.max - lines.min)
        set_top(new_top)

      else
        # @top does not need adjusting

      end
    end

    # @return [Fixnum]
    def column_adjustment
      if offset.x < (columns.min + 1)
        new_left = offset.x - 5
        set_left(new_left)

      elsif offset.x > (columns.max - 1)
        size = columns.max - columns.min
        new_left = offset.x - size + 1 + 5
        set_left(new_left)

      else
        # @left does not need adjusting

      end
    end

    # @param value [Fixnum]
    # @return [Fixnum]
    def set_top(value)
      max_top = (content_height - height)
      @top = [[value, max_top].min, 0].max
    end

    # @param value [Fixnum]
    # @return [Fixnum]
    def set_left(value)
      @left = [value, 0].max
    end

    # @return [Range]
    def lines
      @top..(@top + height - 1)
    end

    # @return [Range]
    def columns
      @left..(@left + width - 1)
    end

    # Returns the height of the content, or when no content, the visible height
    # of the interface.
    #
    # @return [Fixnum]
    def content_height
      if content?
        [content.size, height].max

      else
        height

      end
    end

    # Returns the width of the content, or when no content, the visible width of
    # the interface.
    #
    # @return [Fixnum]
    def content_width
      if content?
        [content_maximum_line_length, width].max

      else
        width

      end
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

  end # Viewport

end # Vedeu
