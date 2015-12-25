require 'vedeu/dsl/all'

# frozen_string_literal: true

module Vedeu

  module Views

    # A composition is a collection of interfaces.
    #
    class Composition

      include Vedeu::Repositories::Model
      include Vedeu::Presentation
      include Vedeu::Views::Value

      collection Vedeu::Views::Views
      deputy     Vedeu::DSL::View
      entity     Vedeu::Views::View

      alias_method :views,  :value
      alias_method :views=, :value=
      alias_method :views?, :value?

      # Returns a new instance of Vedeu::Views::Composition.
      #
      # @param attributes [Hash]
      # @option attributes client [void]
      # @option attributes colour [Vedeu::Colours::Colour]
      # @option attributes style [Vedeu::Presentation::Style]
      # @option attributes value [Vedeu::Views::Views]
      # @return [Vedeu::Views::Composition]
      def initialize(attributes = {})
        defaults.merge!(attributes).each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # @param child [Vedeu::Views::View]
      # @return [Vedeu::Views::Views]
      def add(child)
        @value = value.add(child)
      end
      alias_method :<<, :add

      # @return [Hash]
      def attributes
        {
          client: client,
          colour: colour,
          parent: parent,
          style:  style,
          value:  value,
        }
      end

      private

      # The default values for a new instance of this class.
      #
      # @return [Hash]
      def defaults
        {
          client: nil,
          colour: nil,
          parent: nil,
          style:  nil,
          value:  [],
        }
      end

    end # Composition

  end # Views

end # Vedeu
