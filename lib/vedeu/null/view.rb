require 'vedeu/output/presentation'

module Vedeu

  module Null

    # Provides a non-existent model to swallow messages.
    #
    class View

      include Vedeu::Presentation

      # @!attribute [r] name,
      # @return [String]
      attr_reader :name

      # @!attribute [r] attributes
      # @return [String]
      attr_reader :attributes

      # @!attribute [rw] visible
      # @return [String]
      attr_accessor :visible
      alias_method :visible?, :visible

      # Returns a new instance of Vedeu::Null::View.
      #
      # @param attributes [Hash<Symbol => void>]
      # @option attributes name [String]
      # @return [Vedeu::Null::View]
      def initialize(attributes = {})
        @attributes = attributes
        @name       = @attributes[:name]
        @visible    = false
      end

      # @return [NilClass]
      def null
        nil
      end
      alias_method :parent, :null
      alias_method :zindex, :null

      # @return [Boolean]
      def null?
        true
      end

      # Pretend to store this model in the repository.
      #
      # @return [Vedeu::Null::View]
      def store
        self
      end

    end # View

  end # Null

end # Vedeu
