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
        :_exit_         => [ proc { stop_iteration } ],
        :_keypress_     => [ proc { |key| keypress(key) } ],
        :_mode_switch_  => [ proc { mode_switch } ],
      }
    end

    def keypress(key)
      trigger(:key, key)

      trigger(:_mode_switch_) if key == :escape
    end

    def mode_switch
      fail ModeSwitch
    end

    def stop_iteration
      fail StopIteration
    end
  end
end
