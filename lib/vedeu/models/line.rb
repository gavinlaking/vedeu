require 'virtus'

require 'vedeu/models/attributes/stream_collection'
require 'vedeu/models/colour'
require 'vedeu/models/style'

module Vedeu
  class Line
    include Virtus.model
    include Style

    attribute :colour,  Colour, default: Colour.new
    attribute :model,   Hash
    attribute :streams, StreamCollection
    attribute :style,   Array[String]

    def to_s
      [colour, style, streams].join
    end
  end
end
