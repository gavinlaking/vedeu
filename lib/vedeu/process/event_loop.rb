module Vedeu
  class EventLoop
    class << self
      def start
        new.start
      end
    end

    def initialize
      @running = true
    end

    def start
      tick
    end

    def stop
      @running = false
    end

    def tick
      while @running do
        # command = Interfaces.defined.input
        # command = gets.chomp
        command = "stop"

        stop if command == "stop"

        # Interfaces.defined.output(command)
      end
    end
  end
end
