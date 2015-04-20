module Vedeu

  module DSL

    # Provides methods to be used to define views.
    #
    # @api public
    class Stream

      include Vedeu::DSL
      include Vedeu::DSL::Presentation
      include Vedeu::DSL::Text

      # Returns an instance of DSL::Stream.
      #
      # @param model [Vedeu::Stream]
      # @param client [Object]
      # @return [Vedeu::DSL::Stream]
      def initialize(model, client = nil)
        @model  = model
        @client = client
      end

      # @param block [Proc]
      # @raise [InvalidSyntax] The required block was not given.
      # @return [void]
      def stream(&block)
        fail InvalidSyntax, 'block not given' unless block_given?

        model.add(model.class.build(attributes, &block))
      end

      protected

      # @!attribute [r] client
      # @return [Object]
      attr_reader :client

      # @!attribute [r] model
      # @return [Stream]
      attr_reader :model

      private

      # @return [Hash]
      def attributes
        {
          client: client,
          parent: model.parent,
        }
      end

    end # Stream

  end # DSL

end # Vedeu
