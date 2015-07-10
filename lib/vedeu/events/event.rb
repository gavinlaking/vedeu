require 'vedeu/events/trigger'

module Vedeu

  # Contains all the logic of an event. Handles debouncing and throttling.
  #
  # Vedeu provides an event mechanism to facilitate the functionality of your
  # application. The events are either Vedeu defined, ie. system events or user
  # defined, ie. user events. User events allow you to orchestrate behaviour
  # within your application, ie. the user presses a specific key, you trigger an
  # event to make something happen. Eg. pressing 'p' instructs the player to
  # play.
  #
  # Events described here assume that you have either included Vedeu in your
  # class:
  #
  #   class SomeClassInYourApplication
  #     include Vedeu
  #
  #     bind :event_name do |arg1, arg2|
  #       # Things that should happen when the event is triggered; these can be
  #       # method calls or the triggering of another event or events.
  #     end
  #
  # or, you are prepared to use the `Vedeu` prefix:
  #
  #   class SomeClassInYourApplication
  #     Vedeu.bind(:event_name) do
  #       # Not all events you define will have arguments; like methods.
  #       :do_stuff
  #     end
  #
  # @api public
  class Event

    include Vedeu::Model

    class << self

      # Register an event by name with optional delay (throttling) which when
      # triggered will execute the code contained within the passed block.
      #
      # @param name [Symbol] The name of the event to be triggered later.
      # @param options [Hash] The options to register the event with.
      # @option options :delay [Fixnum|Float] Limits the execution of the
      #   triggered event to only execute when first triggered, with subsequent
      #   triggering being ignored until the delay has expired.
      # @option options :debounce [Fixnum|Float] Limits the execution of the
      #   triggered event to only execute once the debounce has expired.
      #   Subsequent triggers before debounce expiry are ignored.
      # @param block [Proc] The event to be executed when triggered. This block
      #   could be a method call, or the triggering of another event, or
      #   sequence of either/both.
      #
      # @example
      #   Vedeu.bind :my_event do |some, args|
      #     # ... some code here ...
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
      #     # ... some code here ...
      #   end
      #
      #   T = Triggered, X = Executed, i = Ignored.
      #
      #   0.0.....0.2.....0.4.....0.6.....0.8.....1.0.....1.2.....1.4.....1.6...
      #   .T...T...T...T...T...T...T...T...T...T...T...T...T...T...T...T...T...T
      #   .i...i...i...i...i...i...i...X...i...i...i...i...i...i...X...i...i...i
      #
      #   Vedeu.bind(:my_debounced_event, { debounce: 0.7 })
      #     # ... some code here ...
      #   end
      #
      # @return [TrueClass]
      def bind(name, options = {}, &block)
        Vedeu.log(type: :event, message: "Binding: '#{name.inspect}'")

        new(name, options, block).bind
      end
      alias_method :event, :bind
      alias_method :register, :bind

      # Unbind events from a named handler.
      #
      # Removes all events associated with the given name.
      #
      # @example
      #   Vedeu.unbind('some_event')
      #
      # @param name [String]
      # @return [Boolean]
      def unbind(name)
        return false unless Vedeu.events.registered?(name)

        Vedeu.log(type: :event, message: "Unbinding: '#{name.inspect}'")

        Vedeu.events.remove(name)

        true
      end

      extend Forwardable

      def_delegators Vedeu::Trigger, :trigger

    end # Eigenclass

    # Returns a new instance of Vedeu::Event.
    #
    # @param (see Vedeu::Event.bind)
    # @return [Event]
    def initialize(name, options = {}, closure)
      @name         = name
      @options      = options
      @closure      = closure
      @deadline     = 0
      @executed_at  = 0
      @now          = 0
      @repository   = Vedeu.events
    end

    # @see Vedeu::Event.bind
    def bind
      if repository.registered?(name)
        new_collection = repository.find(name).add(self)

      else
        new_collection = Vedeu::EventCollection.new([self], nil, name)

      end

      repository.store(new_collection)

      true
    end

    # Triggers the event based on debouncing and throttling conditions.
    #
    # @param args [Array]
    # @return [void]
    def trigger(*args)
      return execute(*args) unless debouncing? || throttling?

      return execute(*args) if debouncing? && debounce_expired?

      return execute(*args) if throttling? && throttle_expired?
    end

    protected

    # @!attribute [r] closure
    # @return [String]
    attr_reader :closure

    # @!attribute [r] name
    # @return [String]
    attr_reader :name

    private

    # Execute the code stored in the event closure.
    #
    # @param args [void]
    # @return [void]
    def execute(*args)
      @deadline    = 0    # reset deadline
      @executed_at = @now # set execution time to now
      @now         = 0    # reset now

      Vedeu.log(type: :event, message: "Triggering: '#{name.inspect}'")

      closure.call(*args)
    end

    # Returns a boolean indicating whether throttling is required for this
    # event. Setting the delay option to any value greater than 0 will enable
    # throttling.
    #
    # @return [Boolean]
    def throttling?
      @now = Time.now.to_f

      options[:delay] > 0
    end

    # Returns a boolean indicating whether the throttle has expired.
    #
    # @return [Boolean]
    def throttle_expired?
      return true if (@now - @executed_at) > delay

      Vedeu.log(type: :event, message: "Throttling: '#{name.inspect}'")

      false
    end

    # Returns a boolean indicating whether debouncing is required for this
    # event. Setting the debounce option to any value greater than 0 will
    # enable debouncing.
    # Sets the deadline for when this event can be executed to a point in the
    # future determined by the amount of debounce time left.
    #
    # @return [Boolean]
    def debouncing?
      @now = Time.now.to_f

      @deadline = @now + debounce unless deadline?

      options[:debounce] > 0
    end

    # Returns a boolean indicating whether the debounce has expired.
    #
    # @return [Boolean]
    def debounce_expired?
      return true if (@executed_at = @now) > @deadline

      Vedeu.log(type: :event, message: "Debouncing: '#{name.inspect}'")

      false
    end

    # Returns a boolean indicating if this event has a deadline.
    #
    # @return [Boolean]
    def deadline?
      @deadline > 0
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

    # The default values for a new instance of this class.
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
