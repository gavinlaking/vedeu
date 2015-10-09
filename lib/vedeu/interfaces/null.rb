module Vedeu

  module Interfaces

    # Provides a non-existent model to swallow messages.
    #
    class Null < Vedeu::Null::Generic

      include Vedeu::Presentation

      # @!attribute [r] attributes
      # @return [String]
      attr_reader :attributes

      # Returns a new instance of Vedeu::Interfaces::Null.
      #
      # @param attributes [Hash<Symbol => void>]
      # @option attributes name [String|Symbol]
      # @return [Vedeu::Interfaces::Null]
      def initialize(attributes = {})
        @attributes = attributes
        @name       = @attributes[:name]
        @visible    = false
      end

    end # Null

  end # Interfaces

end # Vedeu
