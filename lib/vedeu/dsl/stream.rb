require 'vedeu/dsl/shared/all'

module Vedeu

  module DSL

    # Provides methods to be used to define views.
    #
    # @api public
    class Stream

      include Vedeu::DSL
      include Vedeu::DSL::Colour
      include Vedeu::DSL::Style
      include Vedeu::DSL::Text

      # Returns an instance of DSL::Stream.
      #
      # @param model [Vedeu::Stream]
      def initialize(model, client = nil)
        @model  = model
        @client = client
      end

      # @param block [Proc]
      # @return []
      def stream(&block)
        fail InvalidSyntax, 'block not given' unless block_given?

        model.add(model.class.build(attributes, &block))
      end

      private

      attr_reader :client, :model

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
