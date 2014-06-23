module Vedeu
  module Buffer
    class Line
      include Virtus.model

      attribute :style,      Style
      attribute :foreground, Symbol
      attribute :background, Symbol
      attribute :stream,     Array[Buffer::Stream]

      def to_compositor
        [{ colour: [foreground, background], style: style }, stream]
      end
    end
  end
end
