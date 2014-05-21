module Vedeu
  class Process
    class << self
      def main_sequence(interfaces = nil)
        new(interfaces).initial_state.event_loop
      end
    end

    def initialize(interfaces = nil)
      @interfaces = interfaces
    end

    def main_sequence
      initial_state

      event_loop
    end

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

    # def event_loop
    #   interfaces.event_loop
    # end

    def initial_state
      interfaces.initial_state
    end

    def interfaces
      @interfaces ||= Interfaces.default
    end
  end
end
