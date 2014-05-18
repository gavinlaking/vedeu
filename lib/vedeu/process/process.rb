module Vedeu
  class Process
    class << self
      def event_loop
        new.event_loop
      end
    end

    def initialize
      @running = true
    end

    def event_loop
      while running { print }
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
