module Vedeu
  class OutOfWorkError < StandardError; end
  class OutOfTimeError < StandardError; end

  class Clock
    def self.start(options = {}, &block)
      new(options).tick(&block)
    end

    def initialize(options = {})
      @options = options
    end

    def tick(&block)
      raise OutOfWorkError unless block_given?
      Timeout.timeout(seconds) do
        while true do
          block.call
        end
      end
    rescue Timeout::Error
      raise OutOfTimeError
    end

    private

    def seconds
      options.fetch(:seconds)
    end

    def options
      defaults.merge!(@options)
    end

    def defaults
      { seconds: 1.0 }
    end
  end
end
