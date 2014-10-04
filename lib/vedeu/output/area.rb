module Vedeu

  # Provides a collection of methods useful in calculating geometries for
  # interfaces, cursors and viewports.
  #
  # @todo Rename (min|max)_(x|y) to x_min, y_max etc.
  #
  class Area

    attr_reader  :attributes, :height, :x_min, :y_min, :width, :x, :y

    # Returns an instance of Area.
    #
    # @param  attributes [Hash] The attributes to initialize this class with.
    # @option attributes :height [Fixnum] The number of rows or lines to use.
    # @option attributes :x_min [Fixnum] The starting x coordinate for the area.
    # @option attributes :y_min [Fixnum] The starting y coordinate for the area.
    # @option attributes :width [Fixnum] The number of characters or columns to
    #   use.
    # @option attributes :x [Fixnum] A coordinate in the area. This value should
    #   be an actual terminal coordinate.
    # @option attributes :y [Fixnum] A coordinate in the area. This value should
    #   be an actual terminal coordinate.
    #
    # @return [Area]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)

      @height = @attributes.fetch(:height)
      @x_min  = @attributes.fetch(:x_min)
      @y_min  = @attributes.fetch(:y_min)
      @width  = @attributes.fetch(:width)
      @x      = @attributes.fetch(:x)
      @y      = @attributes.fetch(:y)
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

    # Returns the maximum x coordinate for an area.
    #
    # @return [Fixnum]
    def x_max
      if width == 0
        0

      else
        x_min + width

      end
    end

    # Returns the maximum x index for an area.
    #
    # @return [Fixnum]
    def x_max_index
      if width == 0
        0

      else
        x_indices.last

      end
    end

    # Returns the x coordinate as an offset in the area's x range.
    #
    # @example
    #   # x_range = [4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
    #   # x = 8
    #   x_offset # => 4
    #
    def x_offset
      if width == 0 || x <= x_min
        0

      elsif x >= x_max
        x_max_index

      else
        x_range.index(x)

      end
    end

    # Returns an array with all coordinates from and including x to and
    # including x_max.
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

    # Returns the maximum y coordinate for an area.
    #
    # @return [Fixnum]
    def y_max
      if height == 0
        0

      else
        y_min + height

      end
    end

    # Returns the maximum y index for an area.
    #
    # @return [Fixnum]
    def y_max_index
      if height == 0
        0

      else
        y_indices.last

      end
    end

    # Returns the y coordinate as an offset in the area's y range.
    #
    # @example
    #   # y_range  = [7, 8, 9, 10]
    #   # y = 8
    #   y_offset # => 1
    #
    def y_offset
      if height == 0 || y <= y_min
        0

      elsif y >= y_max
        y_max_index

      else
        y_range.index(y)

      end
    end

    # Returns an array with all coordinates from and including y to and
    # including y_max.
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

    private

    # Returns the default attributes for an Area instance.
    #
    # @return [Hash]
    def defaults
      {
        height: 0,
        x_min:  0,
        y_min:  0,
        width:  0,
        x:      0,
        y:      0,
      }
    end

  end # Area

end # Vedeu
