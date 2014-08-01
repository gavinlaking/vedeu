require 'virtus'

require 'vedeu/models/attributes/stream_collection'
require 'vedeu/models/presentation'
require 'vedeu/models/style'

module Vedeu
  class Line
    include Virtus.model
    include Presentation
    include Style

    attribute :model,   Hash
    attribute :streams, StreamCollection

    def to_s
      [colour, style, streams].join
    end
  end
end
