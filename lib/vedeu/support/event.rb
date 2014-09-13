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

    # @return [Proc]
    attr_reader   :closure

    # @return []
    attr_accessor :deadline

    # @return []
    attr_accessor :executed_at

    # @return []
    attr_accessor :now

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
    # @return [TrueClass|FalseClass]
    def throttling?
      set_time

      options[:delay] > 0
    end

    # Returns a boolean indicating whether the throttle has expired.
    #
    # @api private
    # @return [TrueClass|FalseClass]
    def throttle_expired?
      if elapsed_time > delay
        Vedeu.log("Event throttle has expired for '#{event_name}', executing " \
                  "event.")
        true

      else
        Vedeu.log("Event throttle not yet expired for '#{event_name}'.")
        false

      end
    end

    # Returns a boolean indicating whether debouncing is required for this
    # event. Setting the debounce option to any value greater than 0 will
    # enable debouncing.
    #
    # @api private
    # @return [TrueClass|FalseClass]
    def debouncing?
      set_time

      set_deadline unless has_deadline?

      options[:debounce] > 0
    end

    # Returns a boolean indicating whether the debounce has expired.
    #
    # @api private
    # @return [TrueClass|FalseClass]
    def debounce_expired?
      if set_executed > deadline
        Vedeu.log("Event debounce has expired for '#{event_name}', executing " \
                  "event.")
        true

      else
        Vedeu.log("Event debounce not yet expired for '#{event_name}'.")
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
