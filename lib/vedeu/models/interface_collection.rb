require 'virtus'

require_relative 'interface'
require_relative 'coercions'

module Vedeu
  class InterfaceCollection < Virtus::Attribute
    include Coercions

    def coerce(values)
      return [] if empty?(values)

      if multiple?(values)
        values.map { |v| Interface.new(v) }
      elsif single?(values)
        [Interface.new(values)]
      else
        fail InvalidInterface
      end
    end
  end
end
