require 'oj'
require 'virtus'

require_relative 'presentation'
require_relative 'stream_collection'

module Vedeu
  class Line
    include Virtus.model
    include Presentation

    attribute :streams, StreamCollection

    def to_json
      Oj.dump(json_attributes, mode: :compat)
    end

    def to_s
      [colour, style, streams].join
    end
  end

    private

    def json_attributes
      {
        colour:  colour,
        style:   style,
        streams: streams
      }
    end
end
