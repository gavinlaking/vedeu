require 'virtus'

require_relative '../support/esc'

module Vedeu
  class Foreground < Virtus::Attribute
    def coerce(value)
      return '' unless value

      Esc.foreground_colour(value)
    end
  end
end
