module Vedeu
  class Output
    class << self
      def render(result = nil)
        new(result).render
      end
    end

    def initialize(result = nil)
      @result = result
    end

    def render
      Compositor.arrange(result) unless empty?
    end

    private

    def empty?
      result.nil? || result.empty?
    end

    def result
      @result ||= Queue.dequeue
    end
  end
end
