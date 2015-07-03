module Vedeu

  module Null

    # Provides a non-existent model to swallow messages.
    #
    # @api private
    class Interface

      # Returns a new instance of Vedeu::Null::Interface.
      #
      # @param name [String]
      # @return [Vedeu::Null::Interface]
      def initialize(name = nil)
        @name = name
      end

      # @return [Hash<Symbol => String>]
      def attributes
        {
          name: name,
        }
      end

      # Pretend to store this model in the repository.
      #
      # @return [Vedeu::Null::Interface]
      def store
        self
      end

      # The null interface should not be visible.
      #
      # @return [FalseClass]
      def visible?
        false
      end

      # Override the visible= setter usually found on a Vedeu::Interface.
      #
      # @return [FalseClass]
      def visible=(*)
        false
      end

      protected

      # @!attribute [r] name
      # @return [String]
      attr_reader :name

    end # Interface

  end # Null

end # Vedeu
