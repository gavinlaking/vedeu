module Vedeu
  class Application
    class << self
      def start(options = {})
        new(options).main_sequence
      end
    end

    def initialize(options = {})
      @options = options
    end

    def main_sequence
      Terminal.open(options) do
        Interfaces.initial_state

        EventLoop.start
      end
    ensure
      Terminal.close
    end

    private

    attr_reader :options

    def options
      defaults.merge!(@options)
    end

    def defaults
      {}
    end
  end
end
