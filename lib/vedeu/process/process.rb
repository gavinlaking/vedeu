module Vedeu
  class Process
    class << self
      def event_loop
        new.event_loop
      end
    end

    def initialize; end

    def event_loop
      while true do
        command = evaluate

        break if command == :stop

        Compositor.write(command)
      end
    end

    private

    def evaluate
      Commands.execute(read)
    end

    def read
      Terminal.input
    end
  end
end
