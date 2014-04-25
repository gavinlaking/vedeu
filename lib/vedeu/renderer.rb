module Vedeu
  class Renderer
    class << self
      # @param  composition [Array]
      # @return             [String]
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

    # @return [Enumerator]
    def each(&block)
      composition.each(&block)
    end

    # @return [String]
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
