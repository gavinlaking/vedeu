require 'virtus'

require 'vedeu/support/interface_store'

# Todo: mutation (persistence)

module Vedeu
  class InterfaceCollection < Virtus::Attribute
    def coerce(values)
      return [] if values.nil? || values.empty?

      [values].flatten.map do |value|
        InterfaceStore.update(value.fetch(:name, nil), value)
      end
    end
  end
end
