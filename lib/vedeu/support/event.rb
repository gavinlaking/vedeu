module Vedeu
  class Event
    def initialize(closure, options = {})
      @closure      = closure
      @options      = options
      @deadline     = 0
      @executed_at  = 0
      @now          = 0
    end

    def trigger(*args)
      return execute(*args) unless debouncing? || throttling?

      return execute(*args) if debouncing? && set_executed > deadline

      return execute(*args) if throttling? && elapsed_time > delay
    end

    private

    attr_reader   :closure
    attr_accessor :deadline, :executed_at, :now

    def execute(*args)
      reset_deadline

      set_executed

      reset_time

      closure.call(*args)
    end

    def throttling?
      set_time

      options[:delay] > 0
    end

    def debouncing?
      set_time

      set_deadline unless has_deadline?

      options[:debounce] > 0
    end

    def elapsed_time
      now - @executed_at
    end

    def set_executed
      @executed_at = now
    end

    def set_time
      @now = Time.now.to_f
    end

    def reset_time
      @now = 0
    end

    def has_deadline?
      @deadline > 0
    end

    def reset_deadline
      @deadline = 0
    end

    def set_deadline
      @deadline = now + debounce

      nil
    end

    def debounce
      options[:debounce]
    end

    def delay
      options[:delay]
    end

    def options
      defaults.merge!(@options)
    end

    def defaults
      {
        delay:    0,
        debounce: 0
      }
    end

  end
end
