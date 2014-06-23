module Vedeu
  module Buffer
    class Stream
      include Virtus.model
      include Formatting

      attribute :text, String, default: ''

      def to_compositor
        { style: styles, colour: colour, text: text }
      end
    end
  end
end
