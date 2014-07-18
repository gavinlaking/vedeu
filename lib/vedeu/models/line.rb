require 'oj'
require 'virtus'

require_relative 'presentation'
require_relative 'stream_collection'
require_relative 'style'

module Vedeu
  class Line
    include Virtus.model
    include Presentation
    include Style

    attribute :model,   Hash
    attribute :streams, StreamCollection

    def to_json
      Oj.dump(json_attributes, mode: :compat)
    end

    def to_s
      [colour, style, streams].join
    end

    private

    def json_attributes
      {
        colour:  colour.as_hash,
        style:   style_original,
        streams: streams
      }
    end
  end
end
