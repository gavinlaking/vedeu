module Vedeu
  NotImplemented = Class.new(StandardError)

  class View
    include Vedeu::API

    def self.render(object = nil)
      new(object).render
    end

    def initialize(object = nil)
      @object = object
    end

    def render
      interfaces.map do |interface|
        Buffers.enqueue(interface.name, interface.to_s)
      end
    end

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
