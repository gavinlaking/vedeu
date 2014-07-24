require 'vedeu/models/composition'

module Vedeu
  class Compositor
    def self.enqueue(attributes)
      new(attributes).enqueue
    end

    def initialize(attributes)
      @attributes = attributes
    end

    def enqueue
      composition.interfaces.map { |interface| interface.enqueue }
    end

    private

    attr_reader :attributes

    def composition
      @composition ||= Composition.new(attributes)
    end
  end
end
