require 'virtus'

require 'vedeu/models/attributes/stream_collection'
require 'vedeu/models/colour'
require 'vedeu/models/style'

module Vedeu
  class Line
    include Virtus.model

    attribute :colour,  Colour, default: Colour.new
    attribute :streams, StreamCollection
    attribute :style,   Style,  default: ''

    def to_s
      [colour, style, streams].join
    end
  end
end
