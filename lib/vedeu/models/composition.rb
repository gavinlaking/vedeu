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
        [_interfaces].flatten.map do |attrs|
          stored = Store.query(attrs[:name])

          combined = stored.merge(attrs) do |key, s, a|
            key == :lines && s.empty? ? a : s
          end

          Interface.new(combined)
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
