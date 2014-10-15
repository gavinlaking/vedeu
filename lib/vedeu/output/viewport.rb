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

      @top     = 0
      @left    = 0
    end

    # @return []
    def cursor
      area   = Area.from_interface(interface)
      curs_x = area.x_position(offset.x)
      curs_y = area.y_position(offset.y)

      Cursor.new({ name: interface.name, y: curs_y, x: curs_x }).to_s
    end

    # @return []
    def visible_lines
      set_position

      lines_to_display = content[display_lines] || []
      # lines_to_display[height - 1] ||= []
      # lines_to_display.map do |line|
      #   line ||= ''
      #   line[display_columns] || ''
      # end
    end

    def visible_columns
      display_columns
    end

    private

    attr_reader :interface

    # @return []
    def set_position
      scroll_line_into_view

      scroll_column_into_view

      Vedeu.log("#set_position: y: #{offset.y} x: #{offset.x}")

      Cursors.update({ name: interface.name, y: offset.y, x: offset.x })
    end

    # @return []
    def scroll_line_into_view
      result = line_adjustment
      set_top(result) if result
    end

    # @return []
    def line_adjustment
      if offset.y < display_lines.min
        offset.y

      elsif offset.y > display_lines.max
        offset.y - (display_lines.max - display_lines.min)

      end
    end

    # @param value [Fixnum]
    # @return []
    def set_top(value)
      max_top = (content_height - height)
      @top = [[value, max_top].min, 0].max

      Vedeu.log("#set_top: y: #{@top} x: #{offset.x}")

      Offsets.update({ name: interface.name, y: @top, x: offset.x })

      @top
    end

    # @return []
    def scroll_column_into_view
      result = column_adjustment
      set_left(result) if result
    end

    # @return []
    def column_adjustment
      if offset.x < (display_columns.min + column_scroll_threshold)
        Vedeu.log("#column_adjustment ox < val")
        offset.x - column_scroll_offset

      elsif offset.x > (display_columns.max - column_scroll_threshold)
        Vedeu.log("#column_adjustment ox > val")
        # size = display_columns.max - display_columns.min + 1
        size = display_columns.max - display_columns.min
        Vedeu.log("what: #{offset.x - size + 1 + column_scroll_offset}")
        offset.x - size + 1 + column_scroll_offset

      end
    end

    # @param value [Fixnum]
    # @return []
    def set_left(value)
      @left = [value, 0].max

      Vedeu.log("#set_top: y: #{offset.y} x: #{@left}")

      Offsets.update({ name: interface.name, y: offset.y, x: @left })

      @left
    end

    # @return [Range]
    def display_lines
      @top..(@top + height - 1)
    end

    # @return [Range]
    def display_columns
      @left..(@left + width - 1)
    end

    # @todo Maybe remove, not used.
    # @param line [Fixnum] Current y position
    # @return []
    def visible_area(line)
      line += @top
      start_of_line = [line, @left]
      last_visible_column = @left + width - 1
      end_of_line = [line, last_visible_column]

      start_of_line..end_of_line
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
      content.map do |line|
        line.streams.map(&:content).join.size
      end.max
    end

    # Return a boolean indicating whether this interface currently has content.
    #
    # @return [Boolean]
    def content?
      content.any?
    end

    # @return [Fixnum]
    def column_scroll_threshold
      options[:column_scroll_threshold]
    end

    # @return [Fixnum]
    def column_scroll_offset
      options[:column_scroll_offset]
    end

    # @return [Hash]
    def options
      {
        column_scroll_threshold: 1, # 1
        column_scroll_offset:    5, # 5
      }
    end
  end
end
