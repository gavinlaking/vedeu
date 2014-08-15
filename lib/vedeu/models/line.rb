module Vedeu
  class Line
    def initialize(attributes = {})
      @attributes = attributes
    end

    def attributes
      defaults.merge!(@attributes)
    end

    def colour
      @colour ||= Colour.new(attributes[:colour])
    end

    def streams
      @streams ||= Attributes.coercer(attributes[:streams], Stream, :text)
    end

    def style
      @style ||= Attributes.coerce_styles(attributes[:style])
    end

    def to_s
      [ colour, style, streams ].join
    end

    private

    def defaults
      {
        colour:  {},
        streams: [],
        style:   ''
      }
    end
  end
end
