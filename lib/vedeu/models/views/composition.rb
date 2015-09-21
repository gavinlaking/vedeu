module Vedeu

  module Views

    # A composition is a collection of interfaces.
    #
    class Composition

      include Vedeu::Repositories::Model
      include Vedeu::Presentation

      collection Vedeu::Views::ViewCollection
      member     Vedeu::Views::View

      # @!attribute [r] attributes
      # @return [Hash]
      attr_reader :attributes

      # @!attribute [r] parent
      # @return [NilClass] Composition objects do not have a parent.
      attr_reader :parent

      # Returns a new instance of Vedeu::Views::Composition.
      #
      # @param attributes [Hash]
      # @option attributes client [void]
      # @option attributes colour [Vedeu::Colours::Colour]
      # @option attributes style [Vedeu::Presentation::Style]
      # @option attributes value [Vedeu::Views::ViewCollection]
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
        @value = value.add(child)
      end
      alias_method :<<, :add

      # @return [Vedeu::Views::ViewCollection]
      def value
        collection.coerce(@value, self)
      end
      alias_method :views, :value

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
