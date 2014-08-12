module Vedeu
  class LineCollection < Virtus::Attribute
    include Collection

    def coerce(values)
      coercer(values, Line, :streams)
    end
  end
end
