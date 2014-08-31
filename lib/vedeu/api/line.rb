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
      #         ...
      #
      # @return [Array]
      def stream(&block)
        fail InvalidSyntax, '`stream` requires a block.' unless block_given?

        attributes[:streams] << API::Stream.build({ parent: self }, &block)
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
      #       text 'Some text goes here...'
      #
      #   ...
      #     stream do
      #       text 'Some text goes here...'
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
                                  parent: self,
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
                                  parent: self,
                                  colour: { background: value }
                                }, &block)
      end

    end
  end
end
