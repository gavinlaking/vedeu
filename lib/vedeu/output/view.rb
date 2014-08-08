require 'vedeu/models/composition'

module Vedeu
  class View
    def self.render(data)
      new(data).render
    end

    def initialize(data)
      @data = data
    end

    def render
      Composition.enqueue(interfaces)
    end

    private

    attr_reader :data

    def interfaces
      {
        interfaces: [ data ]
      }
    end
  end
end
