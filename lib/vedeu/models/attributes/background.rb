require 'virtus'

require 'vedeu/output/colour_translator'

module Vedeu
  class Background < Virtus::Attribute
    def coerce(value)
      ColourTranslator.new(value).background
    end
  end
end
