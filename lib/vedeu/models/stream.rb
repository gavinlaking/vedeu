require 'json'
require 'virtus'

require 'vedeu/models/presentation'
require 'vedeu/models/style'

module Vedeu
  class Stream
    include Virtus.model
    include Presentation
    include Style

    attribute :text, String, default: ''

    def to_json
      {
        colour: colour,
        style:  style_original,
        text:   text
      }.to_json
    end

    def to_s(options = {})
      [colour, style, text].join
    end
  end
end
