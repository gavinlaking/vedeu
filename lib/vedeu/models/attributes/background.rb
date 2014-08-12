module Vedeu
  class Background < Virtus::Attribute
    def coerce(value)
      ColourTranslator.new(value).background
    end
  end
end
