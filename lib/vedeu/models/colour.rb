require 'virtus'

require_relative '../support/esc'
require_relative '../support/translator'

module Vedeu
  class Foreground < Virtus::Attribute
    def coerce(value)
      return '' unless value

      [Esc.esc, '38;5;', Translator.translate(value), 'm'].join
    end
  end

  class Background < Virtus::Attribute
    def coerce(value)
      return '' unless value

      [Esc.esc, '48;5;', Translator.translate(value), 'm'].join
    end
  end

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
