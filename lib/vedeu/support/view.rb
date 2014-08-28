module Vedeu
  class View

    include Vedeu::API

    # @param object []
    # @return [Array]
    def self.render(object = nil)
      new(object).enqueue
    end

    # @param object []
    # @return [View]
    def initialize(object = nil)
      @object = object
    end

    # @return [Array]
    def enqueue
      interfaces.map { |interface| Buffers.enqueue(interface.name, interface) }
    end

    # @return [Exception]
    def render
      fail NotImplemented, 'Implement #render on your subclass of Vedeu::View.'
    end
    alias_method :output, :render

    private

    attr_reader :object

    # @return [Array]
    def interfaces
      composition.interfaces
    end

    # @return [Composition]
    def composition
      @_composition ||= Composition.new(attributes)
    end

    # @return []
    def attributes
      render
    end

  end
end
