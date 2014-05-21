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
        Process.main_sequence(interfaces)
      end
    ensure
      Terminal.close
    end

    private

    attr_reader :interfaces, :options

    def options
      defaults.merge!(@options)
    end

    def defaults
      {}
    end
  end
end
