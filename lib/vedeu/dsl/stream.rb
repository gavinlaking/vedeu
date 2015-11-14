module Vedeu

  module DSL

    # Provides methods to be used to define views.
    #
    class Stream

      include Vedeu::DSL
      include Vedeu::DSL::Presentation
      include Vedeu::DSL::Text

      # @param block [Proc]
      # @raise [Vedeu::Error::RequiresBlock]
      # @return [void]
      def stream(&block)
        fail Vedeu::Error::RequiresBlock unless block_given?

        model.add(model.class.build(attributes, &block))
      end

      private

      # Returns the default attributes for the new model.
      #
      # Overrides {Vedeu::DSL#attributes}.
      #
      # @return [Hash<Symbol => void>]
      def attributes
        {
          client: client,
          parent: model.parent,
        }
      end

    end # Stream

  end # DSL

end # Vedeu
