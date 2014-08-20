module Vedeu
  module API
    class Line < Vedeu::Line
      include Helpers

      # @param block [Proc]
      def stream(&block)
        attributes[:streams] << API::Stream.build(&block)
      end

      # @param value [String]
      def text(value)
        attributes[:streams] << { text: value }
      end

      # @param value [String]
      # @param block [Proc]
      def foreground(value = '', &block)
        attributes[:streams] << API::Stream.build({
                                  colour: { foreground: value }
                                }, &block)
      end

      # @param value [String]
      # @param block [Proc]
      def background(value = '', &block)
        attributes[:streams] << API::Stream.build({
                                  colour: { background: value }
                                }, &block)
      end
    end
  end
end
