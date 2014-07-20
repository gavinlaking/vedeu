require 'virtus'

require_relative '../../repository/interface_repository'

module Vedeu
  class InterfaceCollection < Virtus::Attribute
    def coerce(values)
      return [] if values.nil? || values.empty?

      [values].flatten.map do |value|
        InterfaceRepository.update(value.fetch(:name, nil), value)
      end
    end
  end
end
