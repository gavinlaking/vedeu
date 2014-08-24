module Vedeu
  class View

    include Vedeu::API

    # @param object []
    # @return [Array]
    def self.render(object = nil)
      new(object).render
    end

    # @param object []
    # @return [View]
    def initialize(object = nil)
      @object = object
    end

    # @return [Array]
    def render
      interfaces.map { |interface| Buffers.enqueue(interface.name, interface) }
    end

    # @return [Exception]
    def output
      fail NotImplemented, 'Implement #output on your subclass of Vedeu::View.'
    end

    private

    attr_reader :object

    def interfaces
      composition.interfaces
    end

    def composition
      @_composition ||= Composition.new(attributes)
    end

    def attributes
      output
    end

  end
end
