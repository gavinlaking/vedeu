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
        @_attributes ||= defaults.merge!(@attributes)
      end

      def defaults
        {
          colour: {},
          style:  [],
          text:   ''
        }
      end
    end
  end
end
