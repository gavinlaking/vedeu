require 'vedeu/repositories/model'

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
  class Geometry

    extend Forwardable
    include Vedeu::Model

    def_delegators :area,
                   :north,
                   :east,
                   :south,
                   :west,
                   :top,
                   :right,
                   :bottom,
                   :left,
                   :y,
                   :xn,
                   :yn,
                   :x,
                   :height,
                   :width

    # @!attribute [rw] centred
    # @return [Boolean]
    attr_accessor :centred

    # @!attribute [rw] name
    # @return [String]
    attr_accessor :name

    # @!attribute [r] attributes
    # @return [Hash]
    attr_reader :attributes

    # @!attribute [w] height
    # @return [Fixnum]
    attr_writer :height

    # @!attribute [rw] maximised
    # @return [Boolean]
    attr_accessor :maximised
    alias_method :maximised?, :maximised

    # @!attribute [w] width
    # @return [Fixnum]
    attr_writer :width

    # @!attribute [w] x
    # @return [Fixnum]
    attr_writer :x

    # @!attribute [w] xn
    # @return [Fixnum]
    attr_writer :xn

    # @!attribute [w] y
    # @return [Fixnum]
    attr_writer :y

    # @!attribute [w] yn
    # @return [Fixnum]
    attr_writer :yn

    # Returns a new instance of Vedeu::Geometry.
    #
    # @param attributes [Hash]
    # @option attributes centred [Boolean]
    # @option attributes maximised [Boolean]
    # @option attributes height [Fixnum]
    # @option attributes name [String]
    # @option attributes repository [Vedeu::Geometries]
    # @option attributes width [Fixnum]
    # @option attributes x [Fixnum]
    # @option attributes xn [Fixnum]
    # @option attributes y [Fixnum]
    # @option attributes yn [Fixnum]
    # @return [Vedeu::Geometry]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)

      @attributes.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    # @return [String]
    def inspect
      '<Vedeu::Geometry '   \
      "x:#{x} "             \
      "xn:#{xn} "           \
      "y:#{y} "             \
      "yn:#{yn} "           \
      "centred:#{centred} " \
      "maximise:#{maximised}>"
    end

    # @return [Vedeu::Geometry|NilClass]
    def maximise
      return nil unless maximised?

      @maximised = true

      work = store

      Vedeu.trigger(:_refresh_, name)

      work
    end

    # @return [Vedeu::Geometry|NilClass]
    def unmaximise
      return nil if maximised?

      Vedeu.trigger(:_clear_, name)

      @maximised = false

      work = store

      Vedeu.trigger(:_refresh_, name)

      work
    end

    # @param dy [Fixnum]
    # @param dx [Fixnum]
    # @return [Vedeu::Geometry]
    def move(dy = 0, dx = 0)
      new_attrs = {
        centred:    false,
        maximised:  false,
        name:       name,
        x:          (area.x + dx),
        y:          (area.y + dy),
        xn:         (area.xn + dx),
        yn:         (area.yn + dy),
      }

      work = Vedeu::Geometry.new(new_attrs).store

      Vedeu.trigger(:_clear_)
      Vedeu.trigger(:_refresh_, name)

      work
    end

    private

    # @return [Vedeu::Area]
    def area
      @area = Vedeu::Area.from_dimensions(y_yn: y_yn, x_xn: x_xn)
    end

    # @return [Hash<Symbol => Fixnum, Hash]
    def height_attributes
      {
        d:       _y,
        dn:      _yn,
        d_dn:    @height,
        default: Vedeu::Terminal.height,
        options: dimension_options,
      }
    end

    # @return [Hash<Symbol => Fixnum, Hash]
    def width_attributes
      {
        d:        _x,
        dn:      _xn,
        d_dn:    @width,
        default: Vedeu::Terminal.width,
        options: dimension_options,
      }
    end

    # @return [Hash<Symbol => Boolean>]
    def dimension_options
      {
        centred:   centred,
        maximised: maximised,
      }
    end

    # @return [Array<Fixnum>]
    def x_xn
      @x_xn = Vedeu::Dimension.pair(width_attributes)
    end

    # @return [Array<Fixnum>]
    def y_yn
      @y_yn = Vedeu::Dimension.pair(height_attributes)
    end

    # Returns the row/line start position for the interface.
    #
    # @return [Fixnum]
    def _y
      @y.is_a?(Proc) ? @y.call : @y
    end

    # Returns the row/line end position for the interface.
    #
    # @return [Fixnum]
    def _yn
      @yn.is_a?(Proc) ? @yn.call : @yn
    end

    # Returns the column/character start position for the interface.
    #
    # @return [Fixnum]
    def _x
      @x.is_a?(Proc) ? @x.call : @x
    end

    # Returns the column/character end position for the interface.
    #
    # @return [Fixnum]
    def _xn
      @xn.is_a?(Proc) ? @xn.call : @xn
    end

    # @return [Hash]
    def defaults
      {
        centred:    nil,
        height:     nil,
        maximised:  false,
        name:       nil,
        repository: Vedeu.geometries,
        width:      nil,
        x:          nil,
        xn:         nil,
        y:          nil,
        yn:         nil,
      }
    end

  end # Geometry

end # Vedeu
