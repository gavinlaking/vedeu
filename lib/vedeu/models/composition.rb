module Vedeu

  # A composition is a collection of interfaces.
  #
  class Composition

    include Vedeu::Model
    include Vedeu::Presentation

    collection Vedeu::InterfaceCollection
    member     Vedeu::Interface

    # @!attribute [r] attributes
    # @return [Hash]
    attr_reader :attributes

    # Returns a new instance of Vedeu::Composition.
    #
    # @param attributes [Hash]
    # @option attributes colour [Vedeu::Colour]
    # @option attributes interfaces [void]
    # @option attributes style [Vedeu::Style]
    # @return [Vedeu::Composition]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)

      @interfaces = @attributes[:interfaces]
    end

    # @param child [Vedeu::Interface]
    # @return [Vedeu::InterfaceCollection]
    def add(child)
      @interfaces = interfaces.add(child)
    end

    # @return [Vedeu::InterfaceCollection]
    def interfaces
      collection.coerce(@interfaces, self)
    end
    alias_method :value, :interfaces

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
        interfaces: [],
        repository: Vedeu.interfaces,
        style:      nil,
      }
    end

  end # Composition

end # Vedeu
