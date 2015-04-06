module Vedeu

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
      :width,
      :top_left,
      :top_right,
      :bottom_left,
      :bottom_right

    def initialize; end

    def centred
      false
    end

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
