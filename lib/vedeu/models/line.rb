module Vedeu
  class Line
    def initialize(_attributes = {})
      @_attributes = _attributes
    end

    def attributes
      _attributes
    end

    def colour
      @colour ||= Colour.new(_attributes[:colour])
    end

    def streams
      @streams ||= Attributes.coercer(_attributes[:streams], Stream, :text)
    end

    def style
      @style ||= Attributes.coerce_styles(_attributes[:style])
    end

    def to_s
      [ colour, style, streams ].join
    end

    private

    def _attributes
      defaults.merge!(@_attributes)
    end

    def defaults
      {
        colour:  {},
        streams: [],
        style:   ''
      }
    end
  end
end
