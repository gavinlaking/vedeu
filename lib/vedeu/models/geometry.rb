module Vedeu

  # Calculates and provides interface geometry determined by both the client's
  # requirements and the terminal's current viewing area.
  #
  # Geometry for Vedeu, as the same for ANSI terminals, has the origin at
  # top-left, y = 1, x = 1. The 'y' coordinate is deliberately first.
  #
  # @api private
  class Geometry

    attr_reader :attributes, :centred

    # Returns a new instance of Geometry.
    #
    # @param attributes [Hash]
    # @return [Geometry]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)

      @centred = @attributes[:centred]
      @height  = @attributes[:height]
      @width   = @attributes[:width]
    end

    # Returns the row/line start position for the interface.
    #
    # @return [Fixnum]
    def y
      if attributes[:y].is_a?(Proc)
        attributes[:y].call

      else
        attributes[:y]

      end
    end

    # Returns the row/line end position for the interface.
    #
    # @return [Fixnum]
    def yn
      if attributes[:yn].is_a?(Proc)
        attributes[:yn].call

      else
        attributes[:yn]

      end
    end

    # Returns the column/character start position for the interface.
    #
    # @return [Fixnum]
    def x
      if attributes[:x].is_a?(Proc)
        attributes[:x].call

      else
        attributes[:x]

      end
    end

    # Returns the column/character end position for the interface.
    #
    # @return [Fixnum]
    def xn
      if attributes[:xn].is_a?(Proc)
        attributes[:xn].call

      else
        attributes[:xn]

      end
    end

    # Returns a dynamic value calculated from the current terminal width,
    # combined with the desired column start point.
    #
    # If the interface is `centred` then if the terminal resizes, this value
    # should attempt to accommodate that.
    #
    # For uncentred interfaces, when the terminal resizes, then this will help
    # Vedeu render the view to ensure no row/line overruns or that the content
    # is not off-screen.
    #
    # @return [Fixnum]
    def width
      if (x + @width) > Terminal.width
        new_width = @width - ((x + @width) - Terminal.width)
        return new_width < 1 ? 1 : new_width

      else
        @width

      end
    end

    # Returns a dynamic value calculated from the current terminal height,
    # combined with the desired row start point.
    #
    # If the interface is `centred` then if the terminal resizes, this value
    # should attempt to accommodate that.
    #
    # For uncentred interfaces, when the terminal resizes, then this will help
    # Vedeu render the view to ensure the content is not off-screen.
    #
    # @return [Fixnum]
    def height
      if (y + @height) > Terminal.height
        new_height = @height - ((y + @height) - Terminal.height)
        return new_height < 1 ? 1 : new_height

      else
        @height

      end
    end

    # Returns an escape sequence to position the cursor at the top-left
    # coordinate, relative to the interface's position.
    #
    # @param index [Fixnum]
    # @param block [Proc]
    # @return [String]
    def origin(index = 0, &block)
      Esc.set_position(virtual_y[index], left, &block)
    end

    # Returns the top coordinate of the interface, a fixed or dynamic value
    # depending on whether the interface is centred or not.
    #
    # @return [Fixnum]
    def top
      if centred
        Terminal.centre_y - (height / 2)

      else
        y

      end
    end
    alias_method :y_min, :top

    # Returns the row above the top by default.
    #
    # @example
    #   `top` is 4.
    #
    #   north     # => 3
    #   north(2)  # => 2
    #   north(-4) # => 8
    #
    # @param value [Fixnum]
    # @return [Fixnum]
    def north(value = 1)
      top - value
    end

    # Returns the left coordinate of the interface, a fixed or dynamic value
    # depending on whether the interface is centred or not.
    #
    # @return [Fixnum]
    def left
      if centred
        Terminal.centre_x - (width / 2)

      else
        x

      end
    end
    alias_method :x_min, :left

    # Returns the column before left by default.
    #
    # @example
    #   `left` is 8.
    #
    #   west      # => 7
    #   west(2)   # => 6
    #   west(-4)  # => 12
    #
    # @param value [Fixnum]
    # @return [Fixnum]
    def west(value = 1)
      left - value
    end

    # Returns the bottom coordinate of the interface, a fixed or dynamic value
    # depending on the value of {#top}.
    #
    # @return [Fixnum]
    def bottom
      top + height
    end

    # Returns the row below the bottom by default.
    #
    # @example
    #   `bottom` is 12.
    #
    #   south     # => 13
    #   south(2)  # => 14
    #   south(-4) # => 8
    #
    # @param value [Fixnum]
    # @return [Fixnum]
    def south(value = 1)
      bottom + value
    end

    # Returns the right coordinate of the interface, a fixed or dynamic value
    # depending on the value of {#left}.
    #
    # @return [Fixnum]
    def right
      left + width
    end

    # Returns the column after right by default.
    #
    # @example
    #   `right` is 19.
    #
    #   east     # => 20
    #   east(2)  # => 21
    #   east(-4) # => 15
    #
    # @param value [Fixnum]
    # @return [Fixnum]
    def east(value = 1)
      right + value
    end

    # Provides a virtual y position within the interface's dimensions.
    #
    # @example
    #   # top = 3
    #   # bottom = 6
    #   # virtual_y # => [3, 4, 5]
    #
    # @return [Array]
    def virtual_y
      (top...bottom).to_a
    end

    # Provides a virtual x position within the interface's dimensions.
    #
    # @example
    #   # left = 9
    #   # right = 13
    #   # virtual_x # => [9, 10, 11, 12]
    #
    # @return [Array]
    def virtual_x
      (left...right).to_a
    end

    # Returns the actual position of y for a given index. Crudely corrects out
    # of range values.
    #
    # @example
    #   # y_range = [7, 8, 9, 10, 11]
    #   y_position     # => 7
    #   y_position(-2) # => 7
    #   y_position(2)  # => 9
    #   y_position(7)  # => 11
    #
    # @param index [Fixnum]
    # @return [Fixnum]
    def y_position(index = 0)
      if index <= 0
        y_min

      elsif index >= y_max_index
        y_max

      else
        y_range[index]

      end
    end

    # Returns the actual position of x for a given index. Crudely corrects out
    # of range values.
    #
    # @example
    #   # x_range = [4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
    #   x_position     # => 4
    #   x_position(-2) # => 4
    #   x_position(2)  # => 6
    #   x_position(15) # => 13
    #
    # @param index [Fixnum]
    # @return [Fixnum]
    def x_position(index = 0)
      if index <= 0
        x_min

      elsif index >= x_max_index
        x_max

      else
        x_range[index]

      end
    end

    # Provides all the geometry in a convenient hash.
    #
    # @return [Hash]
    def to_h
      {
        centred:         centred,
        height:          height,
        width:           width,
        x:               x,
        y:               y,
        top:             top,
        right:           right,
        bottom:          bottom,
        left:            left,
        north:           north,
        east:            east,
        south:           south,
        west:            west,
        virtual_x:       virtual_x,
        virtual_y:       virtual_y,
      }
    end

    private

    # Returns the y coordinate as an offset index in the area's y range. When a
    # value is provided, the y coordinate is overridden. Crudely corrects out of
    # range values.
    #
    # @example
    #   # y_range  = [7, 8, 9, 10]
    #   # y = 8
    #   y_index     # => 1
    #   y_index(10) # => 3
    #   y_index(5)  # => 0
    #   y_index(15) # => 3
    #
    # @param value [Fixnum]
    # @return [Fixnum]
    def y_index(value = y)
      if height <= 0 || value <= y_min
        0

      elsif value >= y_max
        y_max_index

      else
        y_range.index(value)

      end
    end

    # Returns the x coordinate as an offset index in the area's x range. When a
    # value is provided, the x coordinate is overridden. Crudely corrects out of
    # range values.
    #
    # @example
    #   # x_range = [4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
    #   # x = 8
    #   x_index     # => 4
    #   x_index(11) # => 7
    #   x_index(2)  # => 0
    #   x_index(15) # => 9
    #
    # @param value [Fixnum]
    # @return [Fixnum]
    def x_index(value = x)
      if width <= 0 || value <= x_min
        0

      elsif value >= x_max
        x_max_index

      else
        x_range.index(value)

      end
    end

    # Returns the maximum y index for an area.
    #
    # @example
    #   # height = 3
    #   y_max_index # => 2
    #
    # @return [Fixnum]
    def y_max_index
      return 0 if y_indices.empty?

      y_indices.last
    end

    # Returns the maximum x index for an area.
    #
    # @example
    #   # width = 6
    #   x_max_index # => 5
    #
    # @return [Fixnum]
    def x_max_index
      return 0 if x_indices.empty?

      x_indices.last
    end

    # Returns the same as #y_range, except as indices of an array.
    #
    # @example
    #   # height = 4
    #   y_indices # => [0, 1, 2, 3]
    #
    # @return [Array]
    def y_indices
      (0...height).to_a
    end

    # Returns the same as #x_range, except as indices of an array.
    #
    # @example
    #   # width = 10
    #   x_indices # => [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    #
    # @return [Array]
    def x_indices
      (0...width).to_a
    end

    # Returns an array with all coordinates from x to x_max.
    #
    # @example
    #   # width = 10
    #   # x_min = 4
    #   # x_max = 14
    #   x_range # => [4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
    #
    # @return [Array]
    def x_range
      (x_min...x_max).to_a
    end

    # Returns an array with all coordinates from y to y_max.
    #
    # @example
    #   # height = 4
    #   # y_min  = 7
    #   # y_max  = 11
    #   y_range # => [7, 8, 9, 10]
    #
    # @return [Array]
    def y_range
      (y_min...y_max).to_a
    end

    # Returns the maximum y coordinate for an area.
    #
    # @example
    #   # y_min = 2
    #   # height = 4
    #   y_max # => 6
    #
    # @return [Fixnum]
    def y_max
      if height <= 0
        0

      else
        y_min + height

      end
    end

    # Returns the maximum x coordinate for an area.
    #
    # @example
    #   # x_min = 5
    #   # width = 20
    #   x_max # => 25
    #
    # @return [Fixnum]
    def x_max
      if width <= 0
        0

      else
        x_min + width

      end
    end

    # The default geometry of an interface- full screen.
    #
    # @return [Hash]
    def defaults
      {
        y:       1,
        x:       1,
        width:   Terminal.width,
        height:  Terminal.height,
        centred: false,
        yn:      nil,
        xn:      nil,
      }
    end

  end # Geometry

end # Vedeu
