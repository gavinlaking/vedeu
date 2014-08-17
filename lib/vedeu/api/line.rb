module Vedeu
  module API
    class Line < Vedeu::Line
      include Helpers

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
    end
  end
end
