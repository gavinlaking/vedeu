module Vedeu

  # A Viewport is the visible part of the content within an interface.
  #
  # When a buffer has more lines than the defined height, or more columns than
  # the defined width of the interface, the Viewport class provides 'scrolling'
  # via the cursor's position.
  #
  class Viewport

    # @param interface [Interface] An instance of interface.
    # @return [Viewport]
    def initialize(interface)
      @interface = interface
    end

    # @return [Array]
    def visible_lines
      interface.lines[off_y...(off_y + visible_area.height)]
    end

    private

    attr_reader :interface

    def off_y
      if visible_area.y_indices.include?(offset.y)
        0

      elsif ((content_area.y_max_index - visible_area.y_max_index)...content_area.y_max_index).to_a.include?(offset.y)
        content_area.y_max_index - visible_area.y_max_index

      else
        offset.y

      end
    end

    def off_x
      if visible_area.x_indices.include?(stored_offset.x)
        0

      elsif ((content_area.x_max_index - visible_area.x_max_index)...content_area.x_max_index).to_a.include?(stored_offset.x)
        content_area.x_max_index - visible_area.x_max_index

      else
        stored_offset.x

      end
    end

    def offset
      @_offset = Offsets.update({
        name: stored_offset.name,
        y:    y_offset,
        x:    x_offset,
      })
    end

    def y_offset
      if stored_offset.y < 0
        0

      elsif stored_offset.y > content_area.y_max_index
        content_area.y_max_index

      elsif (stored_offset.y + visible_area.y_max_index) > content_area.y_max_index
        content_area.y_max_index - visible_area.y_max_index

      elsif (stored_offset.y + visible_area.y_max_index) <= content_area.y_max_index
        stored_offset.y

      end
    end

    def x_offset
      if stored_offset.x < 0
        0

      elsif stored_offset.x > content_area.x_max_index
        content_area.x_max_index

      elsif (stored_offset.x + visible_area.x_max_index) > content_area.x_max_index
        content_area.x_max_index - visible_area.x_max_index

      elsif (stored_offset.x + visible_area.x_max_index) <= content_area.x_max_index
        stored_offset.x

      end
    end

    def stored_offset
      @_stored ||= Offsets.find(interface.name)
    end

    # Returns the geometry of the content.
    #
    # @return [Array]
    def content_area
      @_content_area ||= Area.new({
        height: content_height,
        width: content_width
      })
    end

    def content_height
      if content?
        [interface.lines.size, visible_height].max

      else
        visible_height

      end
    end

    def content_width
      if content?
        [content_maximum_line_length, visible_width].max

      else
        visible_width

      end
    end

    def content_maximum_line_length
      interface.lines.map do |line|
        line.streams.map(&:content).join.size
      end.max
    end

    def content?
      interface.lines.any?
    end

    # Returns the geometry of the visible area of the interface.
    #
    # @return [Array]
    def visible_area
      @_visible_area ||= Area.new({
        height: visible_height,
        width: visible_width
      })
    end

    # Return the interfaces height value.
    #
    # @todo I think this should be #viewport_height.
    #
    # @return [Fixnum]
    def visible_height
      interface.height
    end

    # Return the interfaces width value.
    #
    # @todo I think this should be #viewport_width.
    #
    # @return [Fixnum]
    def visible_width
      interface.width
    end

  end # Viewport

end # Vedeu
