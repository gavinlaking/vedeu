require 'vedeu/dsl/composition'
require 'vedeu/models/collection'
require 'vedeu/output/presentation'
require 'vedeu/support/common'

require 'vedeu/models/view/interfaces'
require 'vedeu/models/view/interface'

module Vedeu

  # A composition is a collection of interfaces.
  #
  # @api private
  #
  class Composition

    include Vedeu::Presentation
    include Vedeu::Model

    collection Vedeu::Interfaces
    member     Vedeu::Interface

    attr_reader  :interfaces
    alias_method :value, :interfaces

    # Returns a new instance of Composition.
    #
    # @param attributes [Hash]
    # @option attributes colour []
    # @option attributes interfaces []
    # @option attributes style []
    # @return [Composition]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)
      @interfaces = @attributes[:interfaces]
      @colour     = Colour.coerce(@attributes[:colour])
      @style      = Style.coerce(@attributes[:style])
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
