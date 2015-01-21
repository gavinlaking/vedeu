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
    include Vedeu::Model

    attr_reader  :interfaces
    alias_method :value, :interfaces

    class << self

      # @param attributes [Hash]
      # @param block [Proc]
      # @return [Class]
      def build(attributes = {}, &block)
        attrs = defaults.merge(attributes)

        model = new(attrs[:interfaces], attrs[:colour], attrs[:style])
        model.deputy.instance_eval(&block) if block_given?
        model
      end

      private

      def defaults
        {
          colour:     nil,
          interfaces: [],
          style:      nil,
        }
      end

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

    private

  end # Composition

end # Vedeu
