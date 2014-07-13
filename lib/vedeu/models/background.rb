require 'virtus'

require_relative '../support/esc'

module Vedeu
  class Background < Virtus::Attribute
    def coerce(value)
      return '' unless value

      Esc.background_colour(value)
    end
  end
end
