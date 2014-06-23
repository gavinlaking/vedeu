module Vedeu
  module Buffer
    class Style < Virtus::Attribute
      def coerce(value)
        if value.is_a?(::String) && !value.empty?
          value.split(/ /).map(&:to_sym)
        end
      end
    end
  end
end
