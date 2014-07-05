require 'virtus'

require_relative '../support/cursor'
require_relative '../support/esc'
require_relative 'coercions'

module Vedeu
  class StyleCollection < Virtus::Attribute
    include Coercions

    def coerce(values)
      return '' if empty?(values)

      if multiple?(values)
        values.map { |value| Esc.stylize(value) }.join

      elsif just_text?(values)
        Esc.stylize(values)

      end
    end
  end
end
