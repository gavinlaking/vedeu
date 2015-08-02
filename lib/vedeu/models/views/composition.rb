module Vedeu

  module Views

    # A composition is a collection of interfaces.
    #
    class Composition

      include Vedeu::Model
      include Vedeu::Presentation

      collection Vedeu::Views::ViewCollection
      member     Vedeu::Views::View

      # @!attribute [r] attributes
      # @return [Hash]
      attr_reader :attributes

      # Returns a new instance of Vedeu::Views::Composition.
      #
      # @param attributes [Hash]
      # @option attributes client [void]
      # @option attributes colour [Vedeu::Colour]
      # @option attributes views [void]
      # @option attributes repository [void]
      # @option attributes style [Vedeu::Style]
      # @return [Vedeu::Views::Composition]
      def initialize(attributes = {})
        @attributes = defaults.merge!(attributes)

        @attributes.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # @param child [Vedeu::Views::View]
      # @return [Vedeu::Views::ViewCollection]
      def add(child)
        @views = collection.coerce(@views, self).add(child)
      end

      # @return [Vedeu::Views::Views]
      def views
        collection.coerce(@views, self)
      end
      alias_method :value, :views

      # Composition objects do not have a parent.
      #
      # @return [NilClass]
      def parent
        nil
      end

      private

      # The default values for a new instance of this class.
      #
      # @return [Hash]
      def defaults
        {
          client:     nil,
          colour:     nil,
          views:      [],
          style:      nil,
        }
      end

    end # Composition

  end # Views

end # Vedeu
