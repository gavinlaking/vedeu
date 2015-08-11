module Vedeu

  # Crudely corrects out of range values.
  #
  class Coordinate

    extend Forwardable

    def_delegators :x,
                   :x_position,
                   :xn

    def_delegators :y,
                   :y_position,
                   :yn

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

    private

    # Provide an instance of Vedeu::GenericCoordinate to determine correct x
    # related coordinates.
    #
    # @return [Vedeu::GenericCoordinate]
    def x
      @x ||= Vedeu::GenericCoordinate.new(name: @name, offset: @ox, type: :x)
    end

    # Provide an instance of Vedeu::GenericCoordinate to determine correct y
    # related coordinates.
    #
    # @return [Vedeu::GenericCoordinate]
    def y
      @y ||= Vedeu::GenericCoordinate.new(name: @name, offset: @oy, type: :y)
    end

  end # Coordinate

  # Crudely corrects out of range values.
  #
  class GenericCoordinate

    # Return a new instance of Vedeu::GenericCoordinate.
    #
    # @param attributes [Hash]
    # @option attributes name [String]
    # @option attributes type [Symbol]
    # @option attributes offset [Fixnum]
    # @return [Vedeu::GenericCoordinate]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)

      @attributes.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    # Returns the maximum coordinate for an area.
    #
    # @example
    #   # d = 2
    #   # d_dn = 4
    #   dn # => 6
    #
    # @return [Fixnum]
    def dn
      if d_dn <= 0
        0

      else
        d + d_dn

      end
    end
    alias_method :xn, :dn
    alias_method :yn, :dn

    # Returns the coordinate for a given index.
    #
    # @example
    #   # d_range = [4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
    #   position     # => 4
    #   position(-2) # => 4
    #   position(2)  # => 6
    #   position(15) # => 13
    #
    # @return [Fixnum]
    def position
      pos = case
            when offset <= 0       then d
            when offset > dn_index then dn
            else
              d_range[offset]
            end

      pos = pos < bd ? bd : pos
      pos = pos > bdn ? bdn : pos
      pos
    end
    alias_method :x_position, :position
    alias_method :y_position, :position

    protected

    # @!attribute [r] name
    # @return [String]
    attr_reader :name

    # @!attribute [r] offset
    # @return [Fixnum]
    attr_reader :offset

    # @!attribute [r] type
    # @return [Symbol]
    attr_reader :type

    private

    # @see Vedeu::Borders#by_name
    def border
      @border ||= Vedeu.borders.by_name(name)
    end

    # Return the :x or :y value from the border.
    #
    # @return [Fixnum]
    def d
      border.send(coordinate_type[0])
    end

    # Return the :bx or :by value from the border.
    #
    # @return [Fixnum]
    def bd
      border.send(coordinate_type[1])
    end

    # Return the :bxn or :byn value from the border.
    #
    # @return [Fixnum]
    def bdn
      border.send(coordinate_type[2])
    end

    # Return the :width or :height value from the border.
    #
    # @return [Fixnum]
    def d_dn
      border.send(coordinate_type[3])
    end

    # Ascertain the correct methods to use for determining the coordinates.
    #
    # @return [Fixnum]
    def coordinate_type
      @_type ||= case type
                 when :x then [:x, :bx, :bxn, :width]
                 when :y then [:y, :by, :byn, :height]
                 else
                   fail Vedeu::InvalidSyntax,
                        'Coordinate type not given, cannot continue.'
                 end
    end

    # Returns the maximum index for an area.
    #
    # @example
    #   # d_dn = 3
    #   dn_index # => 2
    #
    # @return [Fixnum]
    def dn_index
      if d_dn < 1
        0

      else
        d_dn - 1

      end
    end

    # Returns an array with all coordinates from d to dn.
    #
    # @example
    #   # d_dn = 10
    #   # d = 4
    #   # dn = 14
    #   d_range # => [4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
    #
    # @return [Array]
    def d_range
      (d...dn).to_a
    end

    # The default values for a new instance of this class.
    #
    # @return [Hash]
    def defaults
      {
        name:   '',
        offset: nil,
        type:   :x,
      }
    end

  end # GenericCoordinate

end # Vedeu
