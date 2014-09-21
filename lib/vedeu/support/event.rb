module Vedeu

  # Contains all the logic of an event. Handles debouncing and throttling.
  #
  # @api private
  class Event

    # Returns a new instance of Event.
    #
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

    # Triggers the event based on debouncing and throttling conditions.
    #
    # @param args [Array]
    # @return []
    def trigger(*args)
      return execute(*args) unless debouncing? || throttling?

      return execute(*args) if debouncing? && debounce_expired?

      return execute(*args) if throttling? && throttle_expired?
    end

    private

    attr_reader   :closure
    attr_accessor :deadline, :executed_at, :now

    # Execute the code stored in the event closure.
    #
    # @api private
    # @return []
    def execute(*args)
      reset_deadline

      set_executed

      reset_time

      closure.call(*args)
    end

    # Returns a boolean indicating whether throttling is required for this
    # event. Setting the delay option to any value greater than 0 will enable
    # throttling.
    #
    # @api private
    # @return [Boolean]
    def throttling?
      set_time

      options[:delay] > 0
    end

    # Returns a boolean indicating whether the throttle has expired.
    #
    # @api private
    # @return [Boolean]
    def throttle_expired?
      if elapsed_time > delay
        true

      else
        Vedeu.log("Event '#{event_name}' is being throttled")

        false

      end
    end

    # Returns a boolean indicating whether debouncing is required for this
    # event. Setting the debounce option to any value greater than 0 will
    # enable debouncing.
    #
    # @api private
    # @return [Boolean]
    def debouncing?
      set_time

      set_deadline unless has_deadline?

      options[:debounce] > 0
    end

    # Returns a boolean indicating whether the debounce has expired.
    #
    # @api private
    # @return [Boolean]
    def debounce_expired?
      if set_executed > deadline
        true

      else
        Vedeu.log("Event '#{event_name}' is being debounced")

        false

      end
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
    # @return [Boolean]
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
    # @return [String]
    def event_name
      options[:event_name].to_s
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
        delay:      0.0,
        debounce:   0.0,
        event_name: '',
      }
    end

  end
end
