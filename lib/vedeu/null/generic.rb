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
      def null(*)
        nil
      end
      alias_method :add, :null
      alias_method :colour, :null
      alias_method :parent, :null
      alias_method :style, :null

      # @return [Boolean]
      def null?
        true
      end

      # @return [Vedeu::Null::Generic]
      def store
        self
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
