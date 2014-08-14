module Vedeu
  class Interface
    extend Forwardable

    def_delegators :geometry, :north, :east, :south, :west,
                              :top, :right, :bottom, :left,
                              :width, :height, :origin

    def initialize(_attributes = {})
      @_attributes = _attributes
    end

    def attributes
      _attributes
    end

    def name
      @name ||= _attributes[:name]
    end

    def group
      @group ||= _attributes[:group]
    end

    def lines
      @lines ||= Attributes.coercer(_attributes[:lines], Line, :streams)
    end

    def colour
      @colour ||= Colour.new(_attributes[:colour])
    end

    def style
      @style ||= Attributes.coerce_styles(_attributes[:style])
    end

    def geometry
      @geometry ||= Geometry.new(_attributes[:geometry])
    end

    def cursor
      @cursor ||= _attributes[:cursor]
    end

    def delay
      @delay || _attributes[:delay]
    end

    def to_s
      Render.call(self)
    end

    private

    def _attributes
      defaults.merge!(@_attributes)
    end

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
