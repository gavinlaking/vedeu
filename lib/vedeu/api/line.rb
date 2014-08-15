module Vedeu
  module API
    class Line
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

      def stream(&block)
        attributes[:streams] << API::Stream.build(&block)
      end

      def text(value)
        attributes[:streams] << { text: value }
      end

      def foreground(value = '', &block)
        attributes[:streams] << API::Stream.build({
                                  colour: { foreground: value }
                                }, &block)
      end

      def background(value = '', &block)
        attributes[:streams] << API::Stream.build({
                                  colour: { background: value }
                                }, &block)
      end

      def attributes
        @_attributes ||= defaults.merge!(@attributes)
      end

      def defaults
        {
          colour:  {},
          style:   [],
          streams: []
        }
      end

      private

      def method_missing(method, *args, &block)
        @self_before_instance_eval.send method, *args, &block
      end
    end
  end
end
