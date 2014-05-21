module Vedeu
  class Application
    class << self
      def start(interfaces = nil, options = {})
        new(interfaces, options).start
      end
    end

    def initialize(interfaces = nil, options = {})
      @interfaces, @options = interfaces, options
    end

    def start
      Terminal.open(options) do
        initial_state

        Process.event_loop
      end
    ensure
      Terminal.close
    end

    private

    attr_reader :options

    def initial_state
      interfaces.initial
    end

    def interfaces
      @interfaces ||= Interfaces.default
    end

    def options
      defaults.merge!(@options)
    end

    def defaults
      {}
    end
  end
end
