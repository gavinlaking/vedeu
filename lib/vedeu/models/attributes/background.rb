require 'virtus'

require 'vedeu/output/colour_translator'

module Vedeu
  class Background < Virtus::Attribute
    def coerce(value)
      return '' if value.nil? || value.empty?

      ["\e[48;5;", ColourTranslator.translate(value), 'm'].join
    end
  end
end
