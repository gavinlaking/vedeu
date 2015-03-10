require 'vedeu/dsl/components/all'
require 'vedeu/repositories/model'

require 'vedeu/geometry/limit'
require 'vedeu/geometry/position'
require 'vedeu/support/terminal'

module Vedeu

  # @todo Consider storing the Terminal size at the time of first creation,
  # this allows us to return the interface to its original dimensions if
  # the terminal resizes back to normal size.
  #
  # Calculates and provides interface geometry determined by both the client's
  # requirements and the terminal's current viewing area.
  #
  # Geometry for Vedeu, as the same for ANSI terminals, has the origin at
  # top-left, y = 1, x = 1. The 'y' coordinate is deliberately first.
  #
  #       x    north    xn           # north:  y - 1
  #     y +--------------+           # top:    y
  #       |     top      |           # west:   x - 1
  #       |              |           # left:   x
  #  west | left   right | east      # right:  xn
  #       |              |           # east:   xn + 1
  #       |    bottom    |           # bottom: yn
  #    yn +--------------+           # south:  yn + 1
  #            south
  #
  class Geometry

    include Vedeu::Model

    # @!attribute [rw] centred
    # @return [Boolean]
    attr_accessor :centred

    # @!attribute [rw] height
    # @return [Fixnum]
    attr_accessor :height

    # @!attribute [rw] name
    # @return [String]
    attr_accessor :name

    # @!attribute [rw] width
    # @return [Fixnum]
    attr_accessor :width

    # @!attribute [r] attributes
    # @return [Hash]
    attr_reader :attributes

    # @!attribute [w] x
    # @return [Fixnum]
    attr_writer :x

    # @!attribute [w] y
    # @return [Fixnum]
    attr_writer :y

    # Returns a new instance of Geometry.
    #
    # @param attributes [Hash]
    # @option attributes centred [Boolean]
    # @option attributes height [Fixnum]
    # @option attributes name [String]
    # @option attributes width [Fixnum]
    # @option attributes x [Fixnum]
    # @option attributes xn [Fixnum]
    # @option attributes y [Fixnum]
    # @option attributes yn [Fixnum]
    # @return [Geometry]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)

      @centred = @attributes[:centred]
      @height  = @attributes[:height]
      @name    = @attributes[:name]
      @width   = @attributes[:width]
      @x       = @attributes[:x]
      @xn      = @attributes[:xn]
      @y       = @attributes[:y]
      @yn      = @attributes[:yn]
      @repository = Vedeu.geometries
    end

    # Returns the row/line start position for the interface.
    #
    # @return [Fixnum]
    def y
      if @y.is_a?(Proc)
        @y.call

      else
        @y

      end
    end

    # Returns the row/line end position for the interface.
    #
    # @return [Fixnum]
    def yn
      if @yn.is_a?(Proc)
        @yn.call

      else
        @yn

      end
    end

    # Returns the column/character start position for the interface.
    #
    # @return [Fixnum]
    def x
      if @x.is_a?(Proc)
        @x.call

      else
        @x

      end
    end

    # Returns the column/character end position for the interface.
    #
    # @return [Fixnum]
    def xn
      if @xn.is_a?(Proc)
        @xn.call

      else
        @xn

      end
    end

    # Returns a dynamic value calculated from the current terminal dimensions,
    # combined with the desired start point.
    #
    # If the interface is `centred` then if the terminal resizes, this value
    # should attempt to accommodate that.
    #
    # For uncentred interfaces, when the terminal resizes, then this will help
    # Vedeu render the view to ensure the content is not off-screen.
    #
    # @return [Fixnum]
    def width
      Vedeu::Limit.apply(x, @width, Vedeu::Terminal.width, Vedeu::Terminal.origin)
    end

    # @see Vedeu::Geometry#width
    def height
      Vedeu::Limit.apply(y, @height, Vedeu::Terminal.height, Vedeu::Terminal.origin)
    end

    # Returns the top coordinate of the interface, a fixed or dynamic value
    # depending on whether the interface is centred or not.
    #
    # @note
    #   Division which results in a non-integer will be rounded down.
    #
    # @return [Fixnum]
    def top
      if centred
        Vedeu::Terminal.centre_y - (height / 2)

      else
        y

      end
    end

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
    # @note
    #   Division which results in a non-integer will be rounded down.
    #
    # @return [Fixnum]
    def left
      if centred
        Vedeu::Terminal.centre_x - (width / 2)

      else
        x

      end
    end

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

    private

    # The default values for a new instance of this class.
    #
    # @return [Hash]
    def defaults
      {
        centred: false,
        client:  nil,
        height:  Vedeu::Terminal.height,
        name:    '',
        width:   Vedeu::Terminal.width,
        x:       1,
        xn:      Vedeu::Terminal.width,
        y:       1,
        yn:      Vedeu::Terminal.height,
      }
    end

  end # Geometry

end # Vedeu
