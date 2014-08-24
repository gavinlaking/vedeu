module Vedeu
  class Event
    def initialize(closure, options = {}, *closure_args)
      @closure      = closure
      @closure_args = closure_args
      @options      = options
      @deadline     = 0
      @executed_at  = 0
      @now          = 0
    end

    def trigger
      set_time

      if debouncing?
        if has_deadline?
          if set_executed > deadline
            execute
          end
        else
          set_deadline
        end
      elsif throttling?
        if elapsed_time > delay
          execute
        end
      else
        execute
      end
    end

    private

    attr_reader   :closure, :closure_args, :now
    attr_accessor :deadline, :executed_at

    def execute
      reset_deadline

      set_executed

      reset_time

      closure.call(*closure_args)
    end

    def throttling?
      options[:delay] > 0
    end

    def debouncing?
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
