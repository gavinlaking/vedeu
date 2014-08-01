require 'virtus'

require 'vedeu/models/colour'
require 'vedeu/models/style'

module Vedeu
  class Stream
    include Virtus.model
    include Style

    attribute :colour, Colour, default: Colour.new
    attribute :style,  Array[String]
    attribute :text,   String, default: ''

    def to_s(options = {})
      [colour, style, text].join
    end
  end
end
