require 'virtus'

require 'vedeu/models/interface'
require 'vedeu/api/store'

module Vedeu
  class InterfaceCollection < Virtus::Attribute
    def coerce(values)
      return [] if values.nil? || values.empty?

      [values].flatten.map do |buffer_attributes|
        interface_attributes = API::Store.query(buffer_attributes[:name])

        Interface.new(buffer_attributes.merge!(interface_attributes))
      end
    end
  end
end
