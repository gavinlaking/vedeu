module Vedeu

  module Menus

    # Provides a non-existent model to swallow messages.
    #
    class Null < Vedeu::Null::Generic

      # Returns an instance of the Vedeu::Menus::Null class.
      #
      # @param attributes [Hash<Symbol => void>]
      # @option attributes name [String|Symbol|NilClass]
      # @return [Vedeu::Menus::Null]
      def initialize(attributes = {})
        @attributes = attributes
        @name       = @attributes[:name]
      end

    end # Null

  end # Menus

end # Vedeu
