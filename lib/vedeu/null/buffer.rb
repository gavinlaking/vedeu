module Vedeu

  module Null

    # Provides a non-existent Vedeu::Buffer that acts like the real thing, but
    # does nothing.
    #
    class Buffer

      # @!attribute [r] name
      # @return [String]
      attr_reader :name

      # Returns a new instance of Vedeu::Null::Buffer.
      #
      # @param attributes [Hash<Symbol => void>]
      # @option attributes name [String|NilClass]
      # @return [Vedeu::Null::Buffer]
      def initialize(attributes = {})
        @attributes = attributes
        @name       = @attributes[:name]
      end

      # @return [NilClass]
      def clear
        nil
      end

      # @return [NilClass]
      def hide
        nil
      end

      # @return [Boolean]
      def null?
        true
      end

      # @return [NilClass]
      def render
        nil
      end

      # @return [NilClass]
      def show
        nil
      end

      # @return [NilClass]
      def toggle
        nil
      end

    end # Buffer

  end # Null

end # Vedeu
