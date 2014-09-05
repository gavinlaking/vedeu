module Vedeu

  # Contains all the logic of the event. Handles debouncing and throttling.
  class Event

    # @param closure [Proc]
    # @param options [Hash]
    # @return [Event]
    def initialize(closure, options = {})
      @closure      = closure
      @options      = options
      @deadline     = 0
      @executed_at  = 0
      @now          = 0
    end

    # @param args [Array]
    # @return []
    def trigger(*args)
      return execute(*args) unless debouncing? || throttling?

      return execute(*args) if debouncing? && set_executed > deadline

      return execute(*args) if throttling? && elapsed_time > delay
    end

    private

    attr_reader   :closure
    attr_accessor :deadline, :executed_at, :now

    # @api private
    # @return []
    def execute(*args)
      reset_deadline

      set_executed

      reset_time

      closure.call(*args)
    end

    # @api private
    # @return [TrueClass|FalseClass]
    def throttling?
      set_time

      options[:delay] > 0
    end

    # @api private
    # @return [TrueClass|FalseClass]
    def debouncing?
      set_time

      set_deadline unless has_deadline?

      options[:debounce] > 0
    end

    # @api private
    # @return [Float]
    def elapsed_time
      now - @executed_at
    end

    # @api private
    # @return [Float]
    def set_executed
      @executed_at = now
    end

    # @api private
    # @return [Float]
    def set_time
      @now = Time.now.to_f
    end

    # @api private
    # @return [Fixnum]
    def reset_time
      @now = 0
    end

    # @api private
    # @return [TrueClass|FalseClass]
    def has_deadline?
      @deadline > 0
    end

    # @api private
    # @return [Fixnum]
    def reset_deadline
      @deadline = 0
    end

    # @api private
    # @return [NilClass]
    def set_deadline
      @deadline = now + debounce

      nil
    end

    # @api private
    # @return [Fixnum|Float]
    def debounce
      options[:debounce] || defaults[:debounce]
    end

    # @api private
    # @return [Fixnum|Float]
    def delay
      options[:delay] || defaults[:delay]
    end

    # @api private
    # @return [Hash]
    def options
      defaults.merge!(@options)
    end

    # @api private
    # @return [Hash]
    def defaults
      {
        delay:    0.0,
        debounce: 0.0
      }
    end

  end
end
