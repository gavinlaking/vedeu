module Vedeu
  module EventRepository
    extend self

    def handlers
      @handlers ||= Hash.new { |h, k| h[k] = [] }.merge(defaults)
    end

    def register(event, &block)
      handlers[event] << block
    end

    def trigger(event, *args)
      handlers[event].each do |handler|
        handler.call(*args)
      end
    end

    private

    def defaults
      {
        :_exit_   => [proc { :exit }],
        :_toggle_ => [proc { :toggle }],
      }
    end
  end
end
