module Vedeu

  module Buffers

    # Provides a non-existent Vedeu::Buffers::Buffer that acts like the real
    # thing, but does nothing.
    #
    class Null

      # @!attribute [r] name
      # @return [String]
      attr_reader :name

      # Returns a new instance of Vedeu::Buffers::Null.
      #
      # @param attributes [Hash<Symbol => void>]
      # @option attributes name [String|NilClass]
      # @return [Vedeu::Buffers::Null]
      def initialize(attributes = {})
        @attributes = attributes
        @name       = @attributes[:name]
      end

      # @return [NilClass]
      def null(*)
        nil
      end
      alias_method :add, :null
      alias_method :clear, :null
      alias_method :hide, :null
      alias_method :render, :null
      alias_method :show, :null
      alias_method :toggle, :null

      # @return [Boolean]
      def null?
        true
      end

    end # Null

  end # Buffers

end # Vedeu
