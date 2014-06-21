module Vedeu
  module Buffer
    class Stream
      include Virtus.model

      attribute :style,      Style
      attribute :foreground, Symbol
      attribute :background, Symbol
      attribute :text,       String
    end
  end
end
