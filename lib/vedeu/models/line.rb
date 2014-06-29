module Vedeu
  module Buffer
    class Line
      include Virtus.model
      include Formatting

      attribute :stream, Array[Buffer::Stream]

      def to_compositor
        [{ style: styles, colour: colour }, *stream.map(&:to_compositor)]
      end
    end
  end
end
