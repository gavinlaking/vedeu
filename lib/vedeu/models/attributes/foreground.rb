require 'virtus'

require 'vedeu/output/colour_translator'

module Vedeu
  class Foreground < Virtus::Attribute
    def coerce(value)
      ColourTranslator.new(value).foreground
    end
  end
end
