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

        attributes[:streams] << API::Stream
          .build({ parent: self.view_attributes }, &block)
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
        stream = API::Stream.build({ colour: { foreground: value },
                                     parent: self.view_attributes }, &block)

        attributes[:streams] << stream
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
        stream = API::Stream.build({ colour: { background: value },
                                     parent: self.view_attributes }, &block)

        attributes[:streams] << stream
      end

    end

  end
end
