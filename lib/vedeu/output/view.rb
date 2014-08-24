module Vedeu
  class View

    include Vedeu::API

    # @param []
    # @return []
    def self.render(object = nil)
      new(object).render
    end

    # @param []
    # @return []
    def initialize(object = nil)
      @object = object
    end

    # @return []
    def render
      interfaces.map { |interface| Buffers.enqueue(interface.name, interface) }
    end

    # @return []
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
