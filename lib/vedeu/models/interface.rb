require 'forwardable'
require 'virtus'

require 'vedeu/models/attributes/line_collection'
require 'vedeu/models/colour'
require 'vedeu/models/style'
require 'vedeu/output/clear'
require 'vedeu/output/render'
require 'vedeu/models/geometry'

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

    def clear
      @_clear ||= Clear.call(self)
    end

    def to_s
      Render.call(self)
    end
  end
end
