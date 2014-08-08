require 'virtus'

require 'vedeu/output/colour_translator'
require 'vedeu/support/esc'

module Vedeu
  class Background < Virtus::Attribute
    def coerce(value)
      return '' if value.nil? || value.empty?

      ["\e[48;5;", ColourTranslator.translate(value), 'm'].join
    end
  end

  class Foreground < Virtus::Attribute
    def coerce(value)
      return '' if value.nil? || value.empty?

      ["\e[38;5;", ColourTranslator.translate(value), 'm'].join
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
