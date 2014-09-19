module Vedeu

  # A Viewport is the visible part of an interface; in most cases, the whole
  # interface. When a buffer has more lines than the defined height of
  # the interface, the Viewport class provides 'scrolling' via the cursor's
  # position.
  class Viewport

    attr_reader :y, :x

    def initialize(lines = [], y = 0, x = 0)
      @lines = lines
      @y = y
      @x = x

      # replace with interface geometry
      #@geometry = Geometry.new({ y: 5, x: 5, width: 40, height: 5 })
      #@height   = @geometry.viewport_height
      #@width    = @geometry.viewport_width

      # replace with real cursor
      #@cursor = Cursor.new({ y: 11, x: 20, name: 'hydrogen', state: :show })

      @content = Content.new(lines)
      @height = 2
      @width = 5
    end

    def visible_lines
      lines[y...(y + height)]
    end

    def visible_columns
      visible_lines.map do |line|
        line.chars[(x...(x + width))].join
      end
    end

    def down
      @y = [@y + 1, content.max_y].min
    end

    def up
      @y = [@y - 1, 0].max
    end

    def right
      @x = [@x + 1, content.width].min
    end

    def left
      @x = [@x - 1, 0].max
    end

    private

    attr_reader :height, :width, :content, :lines

  end
end




    # Converts the cursor's y position into an index for use in the content
    #
    # @example
    #   # virtual_y = [3, 4, 5]
    #   # cursor_y  = 4
    #   # cursor_y_in_content # => 1
    #
    # @return [Fixnum]
    # def cursor_y_in_content
    #   @geometry.virtual_y.rindex(@cursor.attributes[:y])
    # end

    # Converts the cursor's x position into an index for use in the content
    #
    # @example
    #   # virtual_x = [9, 10, 11, 12]
    #   # cursor_x  = 11
    #   # cursor_x_in_content # => 2
    #
    # @return [Fixnum]
    # def cursor_x_in_content
    #   @geometry.virtual_x.rindex(@cursor.attributes[:x])
    # end






























    # def visible
    #   lines[top...bottom]
    # end

    # def visible_line_indices
    #   (0..(lines.size - 1)).to_a[top...bottom]
    # end

    # def cursor_line

    # end







    # def explore
    #   # binding.pry
    # end

    # private

    # attr_reader :lines, :top

    # def bottom
    #   top + height
    # end

    # def height
    #   @geometry.viewport_height
    # end













    # def lines_count
    #   lines.size
    # end

    # def real_y
    #   @geometry.virtual_y
    # end

    # def real_x
    #   @geometry.virtual_x
    # end

    # def lines_virt_y
    #   (1..lines_count).to_a
    # end

    # def lines_virt_x
    #   (1..@geometry.viewport_width).to_a
    # end

    # def curs_virt_y
    #   real_y.index(@cursor[:y])
    # end

    # def curs_virt_x
    #   real_x.index(@cursor[:x])
    # end

    # def curs_min_y
    #   real_y.first
    # end

    # def curs_max_y
    #   if lines_count > @geometry.viewport_height
    #     real_y.first + lines_count

    #   else
    #     real_y.last

    #   end
    # end

    # def curs_min_x
    #   real_x.first
    # end

    # def curs_max_x
    #   real_x.last
    # end



    # def curs_y_to_line_y
    # end

    # def curs_x_to_line_x
    # end

# # terminal area
# term_left   = 1
# term_right  = 6
# term_top    = 1
# term_bottom = 6

# # interface position on terminal (real)
# int_left   = 3
# int_right  = 4
# int_top    = 3
# int_bottom = 4

# # cursor position on terminal (real)
# curs_y = 3
# curs_x = 3

# # cursor position in interface (virt)
# rel_curs_y = 1
# rel_curs_x = 1

# # content position on terminal
# rel_cont_left   = 2
# rel_cont_right  = 5
# rel_cont_top    = 2
# rel_cont_bottom = 5

# # content position on interface
# rel_cont_left   = -1
# rel_cont_right  = 2
# rel_cont_top    = -1
# rel_cont_bottom = 2

# # content size (real)
# cont_left   = 1
# cont_right  = 4
# cont_top    = 1
# cont_bottom = 4
# cont_width  = 4
# cont_h      = 4
