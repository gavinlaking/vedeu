require 'virtus'

require 'vedeu/models/attributes/colour_translator'

module Vedeu
  class Foreground < Virtus::Attribute
    def coerce(value)
      ColourTranslator.new(value).foreground
    end
  end
end
