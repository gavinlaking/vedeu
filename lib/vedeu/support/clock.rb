module Vedeu
  class OutOfWorkError < StandardError; end
  class OutOfTimeError < StandardError; end

  class Clock
    class << self
      def start(options = {}, &block)
        new(options).tick(&block)
      end
    end

    def initialize(options = {})
      @options = options
    end

    def tick(&block)
      raise OutOfWorkError unless block_given?

      timeout do
        while true do
          yield
        end
      end
    end

    private

    def timeout(&block)
      if runtime == :infinite
        yield
      else
        Timeout.timeout(runtime) do
          yield
        end
      end
    rescue Timeout::Error
      raise OutOfTimeError
    end

    def runtime
      options.fetch(:runtime)
    end

    def options
      defaults.merge!(@options)
    end

    def defaults
      { runtime: 5.0 }
    end
  end
end
