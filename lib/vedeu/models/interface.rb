module Vedeu
  class Interface
    extend Forwardable
    include Virtus.model

    attribute :name,     String
    attribute :group,    String
    attribute :lines,    LineCollection
    attribute :colour,   Colour,   default: Colour.new
    attribute :style,    Style,    default: ''
    attribute :geometry, Geometry, default: Geometry.new
    attribute :cursor,   Boolean,  default: true
    attribute :delay,    Float,    default: 0

    def_delegators :@geometry, :north, :east, :south, :west,
                               :top, :right, :bottom, :left,
                               :width, :height, :origin

    def to_s
      Render.call(self)
    end
  end
end
