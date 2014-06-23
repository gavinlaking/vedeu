module Vedeu
  module Buffer
    class Stream
      include Virtus.model

      attribute :foreground, Symbol
      attribute :background, Symbol
      attribute :style,      Style
      attribute :text,       String
    end
  end
end
