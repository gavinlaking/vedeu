module Vedeu
  class Composition
    def initialize(attributes = {})
      @attributes = attributes
    end

    def attributes
      defaults.merge!(@attributes)
    end

    def interfaces
      @interfaces ||= if _interfaces.nil? || _interfaces.empty?
        []

      else
        [_interfaces].flatten.map do |new_attributes|
          stored_attributes = API::Store.query(new_attributes[:name])

          Interface.new(stored_attributes.merge!(new_attributes))
        end

      end
    end

    def to_s
      interfaces.map(&:to_s).join
    end

    private

    def _interfaces
      attributes[:interfaces]
    end

    def defaults
      {
        interfaces: []
      }
    end
  end
end
