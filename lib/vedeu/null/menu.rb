module Vedeu

  module Null

    # Provides a non-existent model to swallow messages.
    #
    class Menu < Vedeu::Null::Generic

      # Returns an instance of the Vedeu::Null::Menu class.
      #
      # @param attributes [Hash<Symbol => void>]
      # @option attributes name [String|NilClass]
      # @return [Vedeu::Null::Menu]
      def initialize(attributes = {})
        @attributes = attributes
        @name       = @attributes[:name]
      end

    end # Menu

  end # Null

end # Vedeu
