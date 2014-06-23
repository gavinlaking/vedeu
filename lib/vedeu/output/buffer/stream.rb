module Vedeu
  module Buffer
    class Stream
      include Virtus.model

      attribute :foreground, Symbol
      attribute :background, Symbol
      attribute :style,      Style
      attribute :text,       String

      def to_compositor
        [{ colour: [foreground, background], style: style }, text]
      end
    end
  end
end
