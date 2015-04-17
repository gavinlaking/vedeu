module Vedeu

  module Null

    # Provides a non-existent model to swallow messages.
    #
    class Generic

      # @return [Vedeu::Null::Generic]
      def initialize; end

      # @return [NilClass]
      def add(*)
        nil
      end

      # @return [NilClass]
      def colour
        nil
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
