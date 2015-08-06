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
        @visible    = false
      end

      # @return [NilClass]
      def null
        nil
      end
      alias_method :hide, :null
      alias_method :parent, :null
      alias_method :show, :null
      alias_method :toggle, :null
      alias_method :zindex, :null

      # @return [Boolean]
      def null?
        true
      end

      # Pretend to store this model in the repository.
      #
      # @return [Vedeu::Null::Interface]
      def store
        self
      end

    end # Interface

  end # Null

end # Vedeu
