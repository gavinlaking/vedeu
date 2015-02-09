require 'vedeu/dsl/composition'
require 'vedeu/models/collection'
require 'vedeu/presentation/presentation'
require 'vedeu/support/common'

require 'vedeu/models/view/interfaces'
require 'vedeu/models/view/interface'

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
        model.deputy(attributes[:client]).instance_eval(&block) if block_given?
        model
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

    end

    # Returns a new instance of Composition.
    #
    # @param interfaces [Interfaces]
    # @return [Composition]
    def initialize(interfaces = [], colour = nil, style = nil)
      @interfaces = interfaces
      @colour     = colour
      @style      = style
    end

    def add(child)
      @interfaces = interfaces.add(child)
    end

    # Returns log friendly output.
    #
    # @return [String]
    def inspect
      "<#{self.class.name} (interfaces:#{interfaces.size})>"
    end

    # @return [Vedeu::Interfaces]
    def interfaces
      children.coerce(@interfaces, self)
    end

    private

    # Return the class name for the children on this model.
    #
    # @return [Class]
    def child
      Vedeu::Interface
    end

    # Return the class name for the children on this model.
    #
    # @return [Class]
    def children
      Vedeu::Interfaces
    end

  end # Composition

end # Vedeu
