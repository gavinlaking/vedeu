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
      Oj.dump(attributes, mode: :compat)
    end

    def to_s
      [colour.to_s, style.to_s, streams].join
    end
  end
end
