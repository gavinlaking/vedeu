require 'vedeu/output/presentation/presentation'

module Vedeu

  module Null

    # Provides a non-existent model to swallow messages.
    #
    class View < Vedeu::Null::Generic

      include Vedeu::Presentation

      # Returns a new instance of Vedeu::Null::View.
      #
      # @param attributes [Hash<Symbol => void>]
      # @option attributes name [String]
      # @return [Vedeu::Null::View]
      def initialize(attributes = {})
        @attributes = attributes
        @name       = @attributes[:name]
        @visible    = false
      end

    end # View

  end # Null

end # Vedeu
