require 'virtus'

require_relative 'presentation'
require_relative '../support/terminal'

module Vedeu
  class Stream
    include Virtus.model
    include Presentation

    attribute :text, String, default: ''

    def to_json
      Oj.dump(json_attributes, mode: :compat)
    end

    def to_s(options = {})
      [colour, style, text].join
    end

    private

    def json_attributes
      {
        colour: colour,
        style:  style,
        text:   text
      }
    end
  end
end
