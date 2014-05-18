module Vedeu
  class Process
    class << self
      def event_loop(&block)
        new.event_loop(&block)
      end
    end

    def initialize(&block)
      @running = true

      yield self if block_given?
    end

    def event_loop(&block)
      while running do
        print
      end
    end

    private

    attr_accessor :running

    def print
      return stop if evaluate == :stop

      Compositor.write(evaluate)
    end

    def evaluate
      Commands.execute(read)
    end

    def read
      Terminal.input
    end

    def stop
      @running = false
    end
  end
end
