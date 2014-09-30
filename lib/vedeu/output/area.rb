module Vedeu

  # Provides a collection of methods useful in calculating geometries for
  # interfaces, cursors and viewports.
  #
  class Area

    attr_reader  :y, :x, :height, :width
    alias_method :min_y, :y
    alias_method :min_x, :x

    # Returns an instance of Area.
    #
    # @param y [Fixnum]
    # @param x [Fixnum]
    # @param height [Fixnum]
    # @param width [Fixnum]
    # @return [Area]
    def initialize(y = 0, x = 0, height = 0, width = 0)
      @y      = y || 0
      @x      = x || 0
      @height = height || 0
      @width  = width  || 0
    end

    # Returns an array with all coordinates from and including y to and
    # including max_y.
    #
    # @example
    #   # height = 4
    #   # min_y  = 7
    #   # max_y  = 11
    #   range_y # => [7, 8, 9, 10]
    #
    # @return [Array]
    def range_y
      (min_y...max_y).to_a
    end

    # Returns an array with all coordinates from and including x to and
    # including max_x.
    #
    # @example
    #   # width = 10
    #   # min_x = 4
    #   # max_x = 14
    #   range_x # => [4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
    #
    # @return [Array]
    def range_x
      (min_x...max_x).to_a
    end

    # Converts #range_y to an array of indicies.
    #
    # @example
    #   # height = 4
    #   indexed_y # => [0, 1, 2, 3]
    #
    # @return [Array]
    def indexed_y
      (0...height).to_a
    end

    # Converts #range_x to an array of indicies.
    #
    # @example
    #   # width = 10
    #   indexed_x # => [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    #
    # @return [Array]
    def indexed_x
      (0...width).to_a
    end

    # Returns the maximum y coordinate for an area.
    #
    # @return [Fixnum]
    def max_y
      if height == 0
        0

      else
        min_y + height

      end
    end

    # Returns the maximum x coordinate for an area.
    #
    # @return [Fixnum]
    def max_x
      if width == 0
        0

      else
        min_x + width

      end
    end

    # Returns the maximum y index for an area.
    #
    # @return [Fixnum]
    def max_y_index
      if height == 0
        0

      else
        indexed_y.last

      end
    end

    # Returns the maximum x coordinate for an area.
    #
    # @return [Fixnum]
    def max_x_index
      if width == 0
        0

      else
        indexed_x.last

      end
    end

    # @return [Area]
    def up
      Area.new(y - 1, x, height, width)
    end

    # @return [Area]
    def down
      Area.new(y + 1, x, height, width)
    end

    # @return [Area]
    def left
      Area.new(y, x - 1, height, width)
    end

    # @return [Area]
    def right
      Area.new(y, x + 1, height, width)
    end

  end # Area

end # Vedeu
