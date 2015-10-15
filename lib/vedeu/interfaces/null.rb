module Vedeu

  module Interfaces

    # Provides a non-existent model to swallow messages.
    #
    class Null < Vedeu::Null::Generic

      include Vedeu::Presentation

      # @!attribute [r] attributes
      # @return [String]
      attr_reader :attributes

      # @return [String]
      def group
        ''
      end

    end # Null

  end # Interfaces

end # Vedeu
