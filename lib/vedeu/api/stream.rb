module Vedeu
  module API
    class Stream
      include Helpers

      def self.build(attributes = {}, &block)
        new(attributes, &block).build
      end

      def initialize(attributes = {}, &block)
        @attributes                = attributes
        @self_before_instance_eval = eval('self', block.binding)

        instance_eval(&block)
      end

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

      private

      def method_missing(method, *args, &block)
        @self_before_instance_eval.send(method, *args, &block)
      end
    end
  end
end
