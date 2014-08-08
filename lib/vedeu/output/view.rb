require 'vedeu/models/composition'

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
      Composition.enqueue(interfaces)
    end

    def output
      fail NotImplemented, 'Implement #output on your subclass of Vedeu::View.'
    end

    private

    attr_reader :object

    def interfaces
      {
        interfaces: [ output ]
      }
    end
  end
end
