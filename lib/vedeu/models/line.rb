require 'json'
require 'virtus'

require_relative 'attributes/stream_collection'
require_relative 'presentation'
require_relative 'style'

module Vedeu
  class Line
    include Virtus.model
    include Presentation
    include Style

    attribute :model,   Hash
    attribute :streams, StreamCollection

    def to_json
      {
        colour:  colour,
        style:   style_original,
        streams: streams
      }.to_json
    end

    def to_s
      [colour, style, streams].join
    end
  end
end
