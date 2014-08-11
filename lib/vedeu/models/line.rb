module Vedeu
  class Line
    include Virtus.model

    attribute :colour,  Colour, default: Colour.new
    attribute :streams, StreamCollection
    attribute :style,   Style,  default: ''

    def to_s
      [ colour, style, streams ].join
    end
  end
end
