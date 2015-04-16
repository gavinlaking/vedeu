module Vedeu

  # Provides geometry for interfaces that do not have geometry defined.
  #
  class NullGeometry

    extend Forwardable

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

    # @!attribute [r] name
    # @return [String|NilClass]
    attr_reader :name

    # Returns a new instance of Vedeu::NullGeometry.
    #
    # @param name [String|NilClass]
    # @return [Vedeu::NullGeometry]
    def initialize(name = nil)
      @name = name
    end

    # @return [FalseClass]
    def centred
      false
    end

    # @return [Vedeu::NullGeometry]
    def store
      self
    end

    private

    # @return [Vedeu::Area]
    def area
      @area ||= Vedeu::Area.from_dimensions(y_yn: y_yn, x_xn: x_xn)
    end

    # @return [Array<Fixnum>]
    def x_xn
      @x_xn ||= Vedeu::Dimension.pair(default: Vedeu::Terminal.width)
    end

    # @return [Array<Fixnum>]
    def y_yn
      @y_yn ||= Vedeu::Dimension.pair(default: Vedeu::Terminal.height)
    end

  end # NullGeometry

end # Vedeu
