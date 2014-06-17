module Vedeu
  class Application
    class << self
      def start(options = {})
        new(options).start
      end
    end

    def initialize(options = {})
      @options = options
    end

    def start
      Terminal.open(options) do
        Output.render

        EventLoop.main_sequence
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
