module Vedeu

  # A Viewport is the visible part of an interface; in most cases, the whole
  # interface.
  #
  # When a buffer has more lines than the defined height of
  # the interface, the Viewport class provides 'scrolling' via the cursor's
  # position.
  class Viewport

    # attr_reader :y, :x

    def initialize(interface)
      @interface = interface

      # @y = y
      # @x = x

      # replace with interface geometry
      #@geometry = Geometry.new({ y: 5, x: 5, width: 40, height: 5 })
      #@height   = @geometry.viewport_height
      #@width    = @geometry.viewport_width

      # replace with real cursor
      #@cursor = Cursor.new({ y: 11, x: 20, name: 'hydrogen', state: :show })

      # @content = Content.new(lines)
      # @height = 2
      # @width = 5
    end

    # def top
    #   if interface.virtual_y.index(@cursor_offset.offset_y) < interface.viewport_height
    #     0
    #   elsif interface.virtual_y.index(@cursor_offset.offset_y) > interface.viewport_height
    #     @cursor_offset.offset_y
    # end

    # def top
    #   if @cursor_offset.offset_y == 0
    #     0
    #   end
    # end



    # def visible_lines
    #   interface.lines[...interface.viewport_height]
    # end





    def visible_lines
      lines[offset.y_offset...(offset.y_offset + interface.viewport_height)]
    end

    # def visible_columns
    #   visible_lines.map do |line|
    #     line.chars[(x...(x + width))].join
    #   end
    # end

    # def down
    #   @y = [@y + 1, content.max_y].min
    # end

    # def up
    #   @y = [@y - 1, 0].max
    # end

    # def right
    #   @x = [@x + 1, content.width].min
    # end

    # def left
    #   @x = [@x - 1, 0].max
    # end

    # private

    # attr_reader :height, :width, :content, :interface, :options

    # def defaults
    #   {
    #     y: 0,
    #     x: 0
    #   }
    # end

    private

    attr_reader :interface

    def lines
      interface.lines
    end

    def offset
      @offset ||= CursorOffset.new(interface)
    end

  end
end

