module Vedeu
  module API
    class Line < Vedeu::Line
      include Helpers

      # Define a stream (a subset of a line).
      #
      # @param block [Proc] Block contains directives relating to API::Stream.
      #
      # @example
      #   ...
      #     line do
      #       stream do
      #         ...
      #       end
      #     end
      #   ...
      #
      # @return [Array]
      def stream(&block)
        attributes[:streams] << API::Stream.build(&block)
      end

      # Define text for a line. Using this directive will not allow stream
      # attributes for this line but is useful for adding lines straight into
      # the interface.
      #
      # @param value [String]
      #
      # @example
      #   TODO: add an example
      #
      # @return [Array]
      def text(value)
        attributes[:streams] << { text: value }
      end

      # @param value [String]
      # @param block [Proc]
      #
      # @example
      #   TODO: add an example
      #
      # @return [Array]
      def foreground(value = '', &block)
        attributes[:streams] << API::Stream.build({
                                  colour: { foreground: value }
                                }, &block)
      end

      # @param value [String]
      # @param block [Proc]
      #
      # @example
      #   TODO: add an example
      #
      # @return [Array]
      def background(value = '', &block)
        attributes[:streams] << API::Stream.build({
                                  colour: { background: value }
                                }, &block)
      end

    end
  end
end
