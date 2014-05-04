module Vedeu
  class Renderer
    include Enumerable

    def self.render(composition = [])
      new(composition).render
    end

    def initialize(composition = [])
      @composition = composition
    end

    def each(&block)
      composition.each(&block)
    end

    def render
      composition.join
    end

    private

    attr_reader :composition
  end
end
