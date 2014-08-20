module Vedeu
  module API
    class Stream < Vedeu::Stream
      include Helpers

      # @param value [Symbol]
      def align(value)
        attributes[:align] = value
      end

      # @param value [String]
      def text(value)
        attributes[:text] = value
      end

      # @param value [Fixnum]
      def width(value)
        attributes[:width] = value
      end
    end
  end
end
