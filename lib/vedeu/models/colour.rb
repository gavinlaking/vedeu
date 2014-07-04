require 'oj'
require 'virtus'

require_relative 'foreground'
require_relative 'background'

module Vedeu
  class Colour
    include Virtus.model

    attribute :foreground, Foreground
    attribute :background, Background

    def to_json
      Oj.dump(attributes, mode: :compat)
    end

    def to_s
      [foreground, background].join
    end
  end
end
