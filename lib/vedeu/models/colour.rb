require 'virtus'

require 'vedeu/support/esc'

module Vedeu
  class Background < Virtus::Attribute
    def coerce(value)
      return '' if value.nil? || value.empty?

      Esc.background_colour(value)
    end
  end

  class Foreground < Virtus::Attribute
    def coerce(value)
      return '' if value.nil? || value.empty?

      Esc.foreground_colour(value)
    end
  end

  class Colour
    include Virtus.model

    attribute :foreground, Foreground, default: ''
    attribute :background, Background, default: ''

    def to_s
      foreground + background
    end
  end
end
