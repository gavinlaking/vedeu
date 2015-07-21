module Vedeu

  # Crudely corrects out of range values.
  #
  class Coordinate

    extend Forwardable

    def_delegators :border,
                   :bx,
                   :bxn,
                   :by,
                   :byn,
                   :height,
                   :width,
                   :x,
                   :y

    # Returns a new instance of Vedeu::Coordinate.
    #
    # @param name [String]
    # @return [Vedeu::Coordinate]
    def initialize(name)
      @name = name
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
      value = if index <= 0
                y

              elsif index > yn_index
                yn

              else
                y_range[index]

              end

      validate_y(value)
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
      value = if index <= 0
                x

              elsif index > xn_index
                xn

              else
                x_range[index]

              end

      validate_x(value)
    end

    protected

    # @!attribute [r] name
    # @return [String]
    attr_reader :name

    private

    # @see Vedeu::Borders#by_name
    def border
      @border ||= Vedeu.borders.by_name(name)
    end

    # @param value [Fixnum]
    # @return [Fixnum]
    def validate_x(value)
      value = value < bx ? bx : value
      value = value > bxn ? bxn : value
      value
    end

    # @param value [Fixnum]
    # @return [Fixnum]
    def validate_y(value)
      value = value < by ? by : value
      value = value > byn ? byn : value
      value
    end

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

  end # Coordinate

end # Vedeu
