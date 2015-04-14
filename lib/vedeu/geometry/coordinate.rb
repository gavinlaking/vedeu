module Vedeu

  # Crudely corrects out of range values.
  #
  class Coordinate

    # @!attribute [r] height
    # @return [Fixnum]
    attr_reader :height

    # @!attribute [r] width
    # @return [Fixnum]
    attr_reader :width

    # @!attribute [r] x
    # @return [Fixnum]
    attr_reader :x

    # @!attribute [r] y
    # @return [Fixnum]
    attr_reader :y

    # Returns a new instance of Vedeu::Coordinate.
    #
    # @param height [Fixnum]
    # @param width [Fixnum]
    # @param x [Fixnum]
    # @param y [Fixnum]
    # @return [Vedeu::Coordinate]
    def initialize(height, width, x, y)
      @height = height
      @width  = width
      @x      = x
      @y      = y
    end

    # Returns the maximum y coordinate for an area.
    #
    # @example
    #   # y = 2
    #   # height = 4
    #   yn # => 6
    #
    # @return [Fixnum]
    def yn
      if height <= 0
        0

      else
        y + height

      end
    end

    # Returns the maximum x coordinate for an area.
    #
    # @example
    #   # x = 5
    #   # width = 20
    #   xn # => 25
    #
    # @return [Fixnum]
    def xn
      if width <= 0
        0

      else
        x + width

      end
    end

    # Returns the index for a given y position.
    #
    # @example
    #   # y_range  = [7, 8, 9, 10]
    #   # y = 8
    #   y_index     # => 1 # because (y_range[1] = 8)
    #   y_index(10) # => 3
    #   y_index(5)  # => 0
    #   y_index(15) # => 3
    #
    # @param position [Fixnum]
    # @return [Fixnum]
    def y_index(position = y)
      if height <= 0 || position <= y
        0

      elsif position >= yn
        yn_index

      else
        y_range.index(position)

      end
    end

    # Returns the index for a given x position.
    #
    # @example
    #   # x_range = [4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
    #   # x = 8
    #   x_index     # => 4 # because (x_range[4] = 8)
    #   x_index(11) # => 7
    #   x_index(2)  # => 0
    #   x_index(15) # => 9
    #
    # @param position [Fixnum]
    # @return [Fixnum]
    def x_index(position = x)
      if width <= 0 || position <= x
        0

      elsif position >= xn
        xn_index

      else
        x_range.index(position)

      end
    end

    # Returns the y coordinate for a given index.
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
        y

      elsif index > yn_index
        yn

      else
        y_range[index]

      end
    end

    # Returns the x coordinate for a given index.
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
        x

      elsif index > xn_index
        xn

      else
        x_range[index]

      end
    end

    private

    # Returns the maximum y index for an area.
    #
    # @example
    #   # height = 3
    #   yn_index # => 2
    #
    # @return [Fixnum]
    def yn_index
      return 0 if y_indices.empty?

      y_indices.last
    end

    # Returns the maximum x index for an area.
    #
    # @example
    #   # width = 6
    #   xn_index # => 5
    #
    # @return [Fixnum]
    def xn_index
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

    # Returns an array with all coordinates from x to xn.
    #
    # @example
    #   # width = 10
    #   # x = 4
    #   # xn = 14
    #   x_range # => [4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
    #
    # @return [Array]
    def x_range
      (x...xn).to_a
    end

    # Returns an array with all coordinates from y to yn.
    #
    # @example
    #   # height = 4
    #   # y  = 7
    #   # yn  = 11
    #   y_range # => [7, 8, 9, 10]
    #
    # @return [Array]
    def y_range
      (y...yn).to_a
    end

    private

    # @!attribute [r] name
    # @return [String]
    attr_reader :name

  end # Coordinate

end # Vedeu
