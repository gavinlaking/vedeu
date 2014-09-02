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
      composition.interfaces.map do |interface|
        Buffers.add(interface.attributes)
      end
    end

    # @return [Exception]
    def render
      fail NotImplemented, 'Implement #render on your subclass of Vedeu::View.'
    end

    private

    attr_reader :object

    # @api private
    # @return [Composition]
    def composition
      @_composition ||= Composition.new(attributes)
    end

    # @api private
    # @return []
    def attributes
      render
    end

  end
end
