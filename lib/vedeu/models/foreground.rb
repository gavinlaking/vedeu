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
end
