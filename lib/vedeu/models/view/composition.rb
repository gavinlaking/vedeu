require 'vedeu/dsl/composition'
require 'vedeu/models/collection'
require 'vedeu/output/presentation'
require 'vedeu/support/common'

require 'vedeu/models/view/collections'
require 'vedeu/models/view/interface'

module Vedeu

  # A composition is a collection of interfaces.
  #
  class Composition

    include Vedeu::Model
    include Vedeu::Presentation

    collection Vedeu::Interfaces
    member     Vedeu::Interface

    # Returns a new instance of Composition.
    #
    # @param attributes [Hash]
    # @option attributes colour [Vedeu::Colour]
    # @option attributes interfaces []
    # @option attributes style [Vedeu::Style]
    # @return [Composition]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)

      @colour     = @attributes[:colour]
      @interfaces = @attributes[:interfaces]
      @repository = Vedeu.interfaces
      @style      = @attributes[:style]
    end

    # @param child [Vedeu::Interface]
    # @return [void]
    def add(child)
      @interfaces = interfaces.add(child)
    end

    # @return [Vedeu::Interfaces]
    def interfaces
      collection.coerce(@interfaces, self)
    end
    alias_method :value, :interfaces

    private

    # The default values for a new instance of this class.
    #
    # @return [Hash]
    def defaults
      {
        client:     nil,
        colour:     nil,
        interfaces: [],
        style:      nil,
      }
    end

  end # Composition

end # Vedeu
