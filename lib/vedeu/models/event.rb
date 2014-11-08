module Vedeu

  # Contains all the logic of an event. Handles debouncing and throttling.
  #
  # @api private
  class Event

    # Returns a new instance of Event.
    #
    # @param name [Symbol]
    # @param options [Hash]
    # @param closure [Proc] The code to be executed when the event is triggered.
    # @return [Event]
    def initialize(name, options = {}, closure)
      @name         = name
      @options      = options
      @closure      = closure
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

    attr_reader   :closure, :name
    attr_accessor :deadline, :executed_at, :now

    # Execute the code stored in the event closure.
    #
    # @param args []
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
    # @return [Boolean]
    def throttling?
      set_time

      options[:delay] > 0
    end

    # Returns a boolean indicating whether the throttle has expired.
    #
    # @return [Boolean]
    def throttle_expired?
      return true if elapsed_time > delay

      Vedeu.log("Throttling event '#{name}'")

      false
    end

    # Returns a boolean indicating whether debouncing is required for this
    # event. Setting the debounce option to any value greater than 0 will
    # enable debouncing.
    #
    # @return [Boolean]
    def debouncing?
      set_time

      set_deadline unless has_deadline?

      options[:debounce] > 0
    end

    # Returns a boolean indicating whether the debounce has expired.
    #
    # @return [Boolean]
    def debounce_expired?
      return true if set_executed > deadline

      Vedeu.log("Debouncing event '#{name}'")

      false
    end

    # @return [Float]
    def elapsed_time
      now - @executed_at
    end

    # @return [Float]
    def set_executed
      @executed_at = now
    end

    # @return [Float]
    def set_time
      @now = Time.now.to_f
    end

    # @return [Fixnum]
    def reset_time
      @now = 0
    end

    # @return [Boolean]
    def has_deadline?
      @deadline > 0
    end

    # @return [Fixnum]
    def reset_deadline
      @deadline = 0
    end

    # @return [NilClass]
    def set_deadline
      @deadline = now + debounce

      nil
    end

    # Return the amount of time in seconds to debounce the event by.
    #
    # @return [Fixnum|Float]
    def debounce
      options[:debounce] || defaults[:debounce]
    end

    # Return the amount of time in seconds to throttle the event by.
    #
    # @return [Fixnum|Float]
    def delay
      options[:delay] || defaults[:delay]
    end

    # Combines the options provided at instantiation with the default values.
    #
    # @return [Hash]
    def options
      defaults.merge!(@options)
    end

    # The default values for a new instance of Event.
    #
    # @return [Hash]
    def defaults
      {
        delay:      0.0,
        debounce:   0.0,
      }
    end

  end # Event

end # Vedeu
