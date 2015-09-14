require 'vedeu/output/presentation'

module Vedeu

  module Null

    # Provides a non-existent model to swallow messages.
    #
    class Interface < Vedeu::Null::Generic

      include Vedeu::Presentation

      # @!attribute [r] attributes
      # @return [String]
      attr_reader :attributes

      # Returns a new instance of Vedeu::Null::Interface.
      #
      # @param attributes [Hash<Symbol => void>]
      # @option attributes name [String]
      # @return [Vedeu::Null::Interface]
      def initialize(attributes = {})
        @attributes = attributes
        @name       = @attributes[:name]
        @visible    = false
      end

    end # Interface

  end # Null

end # Vedeu
