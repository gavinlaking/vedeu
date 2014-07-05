require 'virtus'

require_relative '../repository/interface_repository'
require_relative 'coercions'

module Vedeu
  class InterfaceCollection < Virtus::Attribute
    include Coercions

    def coerce(values)
      return [] if empty?(values)

      if multiple?(values)
        values.map do |value|
          InterfaceRepository.update(value[:name], value)
        end

      elsif single?(values)
        [InterfaceRepository.update(values[:name], values)]

      end
    end
  end
end
