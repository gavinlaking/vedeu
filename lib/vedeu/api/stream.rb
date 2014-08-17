module Vedeu
  module API
    class Stream < Vedeu::Stream
      include Helpers

      def align(value)
        attributes[:align] = value
      end

      def text(value)
        attributes[:text] = value
      end

      def width(value)
        attributes[:width] = value
      end
    end
  end
end
