module Vedeu
  class Events
    def initialize
      @handlers = Hash.new { |h, k| h[k] = [] }
    end

    def on(event, &block)
      handlers[event] << block
    end

    def trigger(event, *args)
      handlers[event].each do |handler|
        handler.call(*args)
      end
    end

    private

    attr_accessor :handlers
  end
end
