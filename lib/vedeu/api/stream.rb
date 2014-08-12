module Vedeu
  module API
    class Stream < Base
      def build
        attributes
      end

      def align(value)
        attributes[:align] = value
      end

      def text(value)
        attributes[:text] = value
      end

      def width(value)
        attributes[:width] = value
      end

      def attributes
        @_attributes ||= { colour: {}, style: [], text: '' }.merge!(@attributes)
      end
    end
  end
end
