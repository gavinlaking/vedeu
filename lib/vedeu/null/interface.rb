require 'vedeu/output/presentation'

module Vedeu

  module Null

    # Provides a non-existent model to swallow messages.
    #
    class Interface

      include Vedeu::Presentation

      # @!attribute [r] name
      # @return [String]
      attr_reader :name

      # @!attribute [r] attributes
      # @return [String]
      attr_reader :attributes

      # @!attribute [rw] visible
      # @return [String]
      attr_accessor :visible
      alias_method :visible?, :visible

      # Returns a new instance of Vedeu::Null::Interface.
      #
      # @param attributes [Hash<Symbol => void>]
      # @option attributes name [String]
      # @return [Vedeu::Null::Interface]
      def initialize(attributes = {})
        @attributes = attributes
        @name       = @attributes[:name]
        @visible    = @attributes[:visible]
      end

      # @return [NilClass]
      def hide
        nil
      end

      # @return [Boolean]
      def null?
        true
      end

      # The null interface should not have a parent.
      #
      # @return [NilClass]
      def parent
        nil
      end

      # @return [NilClass]
      def show
        nil
      end

      # Pretend to store this model in the repository.
      #
      # @return [Vedeu::Null::Interface]
      def store
        self
      end

      # @return [NilClass]
      def toggle
        nil
      end

      # The null interface should not be visible.
      #
      # @return [FalseClass]
      def visible?
        false
      end

    end # Interface

  end # Null

end # Vedeu
