module Vedeu
  class Renderer
    class << self
      def render(composition = [])
        new(composition).render
      end
    end

    include Enumerable

    # @param  composition [Array]
    # @return        [Vedeu::Renderer]
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

    def eol
      "\n"
    end
  end
end
