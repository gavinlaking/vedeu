module Vedeu

  module Null

    # Provides a non-existent model to swallow messages.
    #
    class Interface

      # @!attribute [r] attributes
      # @return [Hash]
      attr_reader :attributes

      # @param attributes [Hash]
      # @return [Vedeu::Null::Interface]
      def initialize(attributes = {})
        @attributes = attributes
      end

    end # Interface

  end # Null

end # Vedeu
