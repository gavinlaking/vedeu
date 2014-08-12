module Vedeu
  class StreamCollection < Virtus::Attribute
    include Collection

    def coerce(values)
      coercer(values, Stream, :text)
    end
  end
end
