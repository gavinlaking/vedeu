require 'vedeu/dsl/composition'
require 'vedeu/models/collection'
require 'vedeu/presentation/presentation'
require 'vedeu/support/common'

module Vedeu

  # A composition is a collection of interfaces.
  #
  # @api private
  class Composition

    include Vedeu::Presentation

    attr_reader  :interfaces
    alias_method :value, :interfaces

    def self.build(interfaces = [], colour = nil, style = nil, &block)
      model = new(interfaces, colour, style)
      model.deputy.instance_eval(&block) if block_given?
      model
    end

    # Returns a new instance of Composition.
    #
    # @param interfaces [Interfaces]
    # @return [Composition]
    def initialize(interfaces = [], colour = nil, style = nil)
      @interfaces = Vedeu::Model::Interfaces.new(interfaces, self)
      @colour     = colour
      @style      = style
    end

    # Returns the class responsible for defining the DSL methods of this model.
    #
    # @return [DSL::Composition]
    def deputy
      Vedeu::DSL::Composition.new(self)
    end

  end # Composition

end # Vedeu
