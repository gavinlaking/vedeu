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
    # @param oy [Fixnum]
    # @param ox [Fixnum]
    # @return [Vedeu::Coordinate]
    def initialize(name, oy, ox)
      @name = name
      @ox   = ox
      @oy   = oy
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
    # @return [Fixnum]
    def y_position
      pos = case
            when oy <= 0       then y
            when oy > yn_index then yn
            else
              y_range[oy]
            end

      validate_y(pos)
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
    # @return [Fixnum]
    def x_position
      pos = case
            when ox <= 0       then x
            when ox > xn_index then xn
            else
              x_range[ox]
            end

      validate_x(pos)
    end

    protected

    # @!attribute [r] name
    # @return [String]
    attr_reader :name

    # @!attribute [r] oy
    # @return [Fixnum]
    attr_reader :oy

    # @!attribute [r] ox
    # @return [Fixnum]
    attr_reader :ox

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
      if height < 1
        0

      else
        height - 1

      end
    end

    # Returns the maximum x index for an area.
    #
    # @example
    #   # width = 6
    #   xn_index # => 5
    #
    # @return [Fixnum]
    def xn_index
      if width < 1
        0

      else
        width - 1

      end
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
