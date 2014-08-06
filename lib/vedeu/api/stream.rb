require 'vedeu/api/base'

module Vedeu
  module API
    class Stream < Base
      def build
        attributes
      end

      def text(value)
        attributes[:text] = value
      end

      def attributes
        @_attributes ||= { colour: {}, style: [], text: '' }.merge!(@attributes)
      end
    end
  end
end
