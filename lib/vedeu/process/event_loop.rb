module Vedeu
  class Collapse < StandardError; end

  class EventLoop
    class << self
      def main_sequence
        new.main_sequence
      end
    end

    def initialize
      @running = true
    end

    def main_sequence
      while @running do
        Interfaces.defined.input

        Interfaces.defined.output
      end
    rescue Collapse
      stop
    end

    def stop
      @running = false
    end
  end
end
