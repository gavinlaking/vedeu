require 'vedeu/dsl/dsl'
require 'vedeu/models/model'
require 'vedeu/support/repository'
require 'vedeu/events/trigger'

module Vedeu

  # Contains all the logic of an event. Handles debouncing and throttling.
  #
  # @api private
  class Event

    include Vedeu::DSL
    include Vedeu::Model

    class << self

      # Register an event by name with optional delay (throttling) which when
      # triggered will execute the code contained within the passed block.
      #
      # @param name  [Symbol] The name of the event which will be triggered later.
      # @param [Hash] options The options to register the event with.
      # @option options :delay [Fixnum|Float] Limits the execution of the
      #   triggered event to only execute when first triggered, with subsequent
      #   triggering being ignored until the delay has expired.
      # @option options :debounce [Fixnum|Float] Limits the execution of the
      #   triggered event to only execute once the debounce has expired.
      #   Subsequent triggers before debounce expiry are ignored.
      # @param block [Proc] The event to be executed when triggered. This block
      #   could be a method call, or the triggering of another event, or sequence
      #   of either/both.
      #
      # @example
      #   Vedeu.bind :my_event do |some, args|
      #     ... some code here ...
      #
      #     Vedeu.trigger(:my_other_event)
      #   end
      #
      #   T = Triggered, X = Executed, i = Ignored.
      #
      #   0.0.....0.2.....0.4.....0.6.....0.8.....1.0.....1.2.....1.4.....1.6...
      #   .T...T...T...T...T...T...T...T...T...T...T...T...T...T...T...T...T...T
      #   .X...i...i...i...i...X...i...i...i...i...X...i...i...i...i...i...i...i
      #
      #   Vedeu.bind(:my_delayed_event, { delay: 0.5 })
      #     ... some code here ...
      #   end
      #
      #   T = Triggered, X = Executed, i = Ignored.
      #
      #   0.0.....0.2.....0.4.....0.6.....0.8.....1.0.....1.2.....1.4.....1.6...
      #   .T...T...T...T...T...T...T...T...T...T...T...T...T...T...T...T...T...T
      #   .i...i...i...i...i...i...i...X...i...i...i...i...i...i...X...i...i...i
      #
      #   Vedeu.bind(:my_debounced_event, { debounce: 0.7 })
      #     ... some code here ...
      #   end
      #
      # @return [TrueClass]
      def bind(name, options = {}, &block)
        Vedeu.log("Binding event: '#{name}'")

        new(name, options, block).bind
      end
      alias_method :event, :bind
      alias_method :register, :bind

      # @see Vedeu::Trigger.trigger
      def trigger(name, *args)
        Vedeu::Trigger.trigger(name, *args)
      end

      # Unbind events from a named handler.
      #
      # @param name [String]
      # @return [Boolean]
      def unbind(name)
        return false unless Vedeu.events_repository.registered?(name)

        Vedeu.log("Unbinding event: '#{name}")

        Vedeu.events_repository.remove(name)
        true
      end
      alias_method :unevent, :unbind

    end

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

    def bind
      if repository.registered?(name)
        collection     = repository.find(name)
        new_collection = collection.add(self)

      else
        new_collection = Vedeu::Model::Collection.new([self], nil, name)

      end

      repository.store(new_collection)

      true
    end

    # Triggers the event based on debouncing and throttling conditions.

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

    # @return [Repository] The repository class for this model.
    def repository
      Vedeu.events_repository
    end

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
      defaults.merge(@options)
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

  def_delegators Vedeu::Event, :bind, :trigger, :unbind

  # deprecated heathen
  def_delegators Vedeu::Event, :event, :unevent

end # Vedeu
