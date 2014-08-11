module Vedeu
  class InterfaceCollection < Virtus::Attribute
    def coerce(values)
      return [] if values.nil? || values.empty?

      [values].flatten.map do |view_attributes|
        stored_attributes = API::Store.query(view_attributes[:name])

        Interface.new(stored_attributes.merge!(view_attributes))
      end
    end
  end
end
