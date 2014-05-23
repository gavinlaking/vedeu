module Vedeu
  class Renderer
    class << self
      def write(composition)
        new(composition).write
      end
    end

    def initialize(composition)
      @composition = composition
    end

    def write
      composition.map { |stream| Terminal.output(stream) }
    end

    private

    attr_reader :composition
  end
end
