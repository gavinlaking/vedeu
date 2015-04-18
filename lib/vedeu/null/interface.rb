module Vedeu

  module Null

    # Provides a non-existent model to swallow messages.
    #
    class Interface

      # @param name [String]
      # @return [Vedeu::Null::Interface]
      def initialize(name = nil)
        @name = name
      end

      # @return [Hash<Symbol => String>]
      def attributes
        {
          name: name
        }
      end

      private

      # @!attribute [r] name
      # @return [String]
      attr_reader :name

    end # Interface

  end # Null

end # Vedeu
