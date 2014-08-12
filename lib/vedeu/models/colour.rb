module Vedeu
  class Colour
    include Virtus.model

    attribute :foreground, Foreground, default: ''
    attribute :background, Background, default: ''

    def to_s
      foreground + background
    end
  end
end
