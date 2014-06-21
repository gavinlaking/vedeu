module Vedeu
  module Buffer
    class Style < Virtus::Attribute
      def coerce(value)
        if value.is_a?(::String)
          value.split(/ /).map(&:to_sym)
        end
      end
    end

    class Stream
      include Virtus.model

      attribute :style,      Style
      attribute :foreground, Symbol
      attribute :background, Symbol
      attribute :text,       String
    end

    class Line
      include Virtus.model

      attribute :style,      Style
      attribute :foreground, Symbol
      attribute :background, Symbol
      attribute :stream,     Array[Stream]
    end

    class Interface
      include Virtus.model

      attribute :name, String
      attribute :line, Array[Line]
    end

    class Composition
      include Virtus.model

      attribute :interface, Array[Interface]
    end
  end
end
