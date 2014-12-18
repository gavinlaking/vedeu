module Vedeu

  module DSL

    # Provides methods to be used to define views.
    #
    # @api public
    class Line

      include DSL::Colour
      include DSL::Style

      # Returns an instance of DSL::Line.
      #
      # @param model [Line]
      def initialize(model)
        @model = model
      end

      # Define a stream (a subset of a line).
      #
      # @param block [Proc] Block contains directives relating to API::Stream.
      #
      # @example
      #   ...
      #     line do
      #       stream do
      #         ...
      #
      # @raise [InvalidSyntax] When the required block is not given.
      # @return [Array]
      def stream(&block)
        fail InvalidSyntax, '`stream` requires a block.' unless block_given?

        model.add_stream({ parent: self.view_attributes }, &block)
      end

      # Define text for a line. Using this directive will not allow stream
      # attributes for this line but is useful for adding lines straight into
      # the interface.
      #
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
        model.add_stream({ text: value })
      end

      private

      attr_reader :model

    end # Line

  end # DSL

end # Vedeu
