module Vedeu
  module API
    class Line < Vedeu::Line
      include Helpers

      # Define a stream (a subset of a line).
      #
      # @api public
      # @param block [Proc] Block contains directives relating to API::Stream.
      #
      # @example
      #   ...
      #     line do
      #       stream do
      #         ... other stream directives ...
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
      # @api public
      # @param value [String]
      #
      # @example
      #   ...
      #     line do
      #       text 'Some text to display...'
      #
      # @return [Array]
      def text(value)
        attributes[:streams] << { text: value }
      end

      # @api public
      # @param value [String]
      # @param block [Proc]
      #
      # @example
      #   ...
      #     line do
      #       foreground '#00ff00' do
      #         ... other stream directives ...
      #
      # @return [Array]
      def foreground(value = '', &block)
        attributes[:streams] << API::Stream.build({
                                  colour: { foreground: value }
                                }, &block)
      end

      # @api public
      # @param value [String]
      # @param block [Proc]
      #
      # @example
      #   ...
      #     line do
      #       background '#0022ff' do
      #         ... other stream directives ...
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
