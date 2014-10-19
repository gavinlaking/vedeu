module Vedeu

  # Provides a collection of methods useful in calculating geometries for
  # interfaces, cursors and viewports.
  #
  class Area

    attr_reader  :attributes, :height, :x_min, :y_min, :width, :x, :y

    # Returns an instance of Area.
    #
    # @param interface [Interface]
    # @return [Area]
    def self.from_interface(interface)
      new({
        y_min:  interface.top,
        height: interface.height,
        x_min:  interface.left,
        width:  interface.width
      })
    end

    # Returns an instance of Area.
    #
    # @param  attributes [Hash] The attributes to initialize this class with.
    # @option attributes :y_min [Fixnum] The starting y coordinate for the area,
    #   equivalent to +:top+ in {Geometry} parlance.
    # @option attributes :height [Fixnum] The number of rows or lines to use.
    # @option attributes :x_min [Fixnum] The starting x coordinate for the area,
    #   equivalent to +:left+ in {Geometry} parlance.
    # @option attributes :width [Fixnum] The number of characters or columns to
    #   use.
    # @option attributes :y [Fixnum] A coordinate in the area. This value should
    #   be an actual terminal coordinate.
    # @option attributes :x [Fixnum] A coordinate in the area. This value should
    #   be an actual terminal coordinate.
    #
    # @return [Area]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)

      @y_min  = @attributes.fetch(:y_min)
      @height = @attributes.fetch(:height)

      @x_min  = @attributes.fetch(:x_min)
      @width  = @attributes.fetch(:width)

      @y      = @attributes.fetch(:y)
      @x      = @attributes.fetch(:x)
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
