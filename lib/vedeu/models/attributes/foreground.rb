require 'virtus'

require 'vedeu/output/colour_translator'

module Vedeu
  class Foreground < Virtus::Attribute
    def coerce(value)
      return '' if value.nil? || value.empty?

      ["\e[38;5;", ColourTranslator.translate(value), 'm'].join
    end
  end
end
