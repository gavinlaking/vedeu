module Vedeu
  class Interface
    extend Forwardable

    def_delegators :geometry, :north, :east, :south, :west,
                              :top, :right, :bottom, :left,
                              :width, :height, :origin

    def initialize(attributes = {})
      @attributes = attributes
    end

    def attributes
      @_attributes ||= defaults.merge!(@attributes)
    end

    def name
      @name ||= attributes[:name]
    end

    def group
      @group ||= attributes[:group]
    end

    def lines
      @lines ||= Attributes.coercer(attributes[:lines], Line, :streams)
    end

    def colour
      @colour ||= Colour.new(attributes[:colour])
    end

    def style
      @style ||= Attributes.coerce_styles(attributes[:style])
    end

    def geometry
      @geometry ||= Geometry.new(attributes[:geometry])
    end

    def cursor
      @cursor ||= attributes[:cursor]
    end

    def delay
      @delay || attributes[:delay]
    end

    def to_s
      Render.call(self)
    end

    private

    def defaults
      {
        name:     '',
        group:    '',
        lines:    [],
        colour:   {},
        style:    '',
        geometry: {},
        cursor:   true,
        delay:    0.0
      }
    end
  end
end
