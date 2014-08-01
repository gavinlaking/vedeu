require 'virtus'

require 'vedeu/models/presentation'
require 'vedeu/models/style'

module Vedeu
  class Stream
    include Virtus.model
    include Presentation
    include Style

    attribute :text, String, default: ''


    def to_s(options = {})
      [colour, style, text].join
    end
  end
end
