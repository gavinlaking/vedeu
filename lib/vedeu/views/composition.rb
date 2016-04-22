require 'vedeu/dsl/all'

# frozen_string_literal: true

module Vedeu

  module Views

    # A composition is a collection of interfaces.
    #
    # @api private
    #
    class Composition

      include Vedeu::Repositories::Model
      include Vedeu::Presentation
      include Vedeu::Presentation::Colour
      include Vedeu::Presentation::Position
      include Vedeu::Presentation::Styles
      include Vedeu::Views::Value

      collection Vedeu::Views::Views
      deputy     Vedeu::DSL::View
      entity     Vedeu::Views::View

      alias views value
      alias views= value=
      alias views? value?

      # Returns a new instance of Vedeu::Views::Composition.
      #
      # @param attributes [Hash<Symbol => void>]
      # @option attributes client [void]
      # @option attributes colour [Vedeu::Colours::Colour]
      # @option attributes parent [NilClass] The parent of a
      #   Vedeu::Views::Composition should be nil.
      # @option attributes style [Vedeu::Presentation::Style]
      # @option attributes value [Vedeu::Views::Views]
      # @return [Vedeu::Views::Composition]
      def initialize(attributes = {})
        defaults.merge!(attributes).each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # @return [Hash<Symbol => void>]
      def attributes
        {
          client: client,
          colour: colour,
          parent: parent,
          style:  style,
          value:  value,
        }
      end

      # @param refresh [Boolean] Should the buffer(s) of the view(s)
      #   in this composition be refreshed once stored? Default:
      #   false.
      # @return [Vedeu::Views::Composition]
      def update_buffers(refresh = false)
        views.each { |view| view.update_buffer(refresh) } if views?

        self
      end

      private

      # @macro defaults_method
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
