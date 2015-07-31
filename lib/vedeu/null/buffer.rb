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

    end # Buffer

  end # Null

end # Vedeu
