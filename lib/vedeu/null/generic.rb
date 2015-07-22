module Vedeu

  module Null

    # Provides a non-existent model to swallow messages.
    #
    class Generic

      # Returns an instance of the Vedeu::Null::Generic class.
      #
      # @param attributes [Hash<Symbol => void>]
      # @option attributes name [String|NilClass]
      # @return [Vedeu::Null::Generic]
      def initialize(attributes = {})
        @attributes = attributes
        @name       = @attributes[:name]
      end

      # @return [NilClass]
      def add(*)
        nil
      end

      # @return [NilClass]
      def colour
        nil
      end

      # @return [Boolean]
      def null?
        true
      end

      # @return [NilClass]
      def parent
        nil
      end

      # @return [Vedeu::Null::Generic]
      def store
        self
      end

      # @return [NilClass]
      def style
        nil
      end

      # The generic null should not be visible.
      #
      # @return [FalseClass]
      def visible?
        false
      end
      alias_method :visible, :visible?

      # @return [FalseClass]
      def visible=(*)
        false
      end

    end # Generic

  end # Null

end # Vedeu
