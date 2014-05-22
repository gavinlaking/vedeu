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
        initial_state

        event_loop
      end
    ensure
      Terminal.close
    end

    private

    attr_reader :options

    def event_loop
      interfaces.event_loop
    end

    def initial_state
      interfaces.initial_state
    end

    def interfaces
      @interfaces ||= Interfaces.defined || Interfaces.default
    end

    def options
      defaults.merge!(@options)
    end

    def defaults
      {}
    end
  end
end
