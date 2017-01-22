# frozen_string_literal: true

module Vedeu

  module Events

    # Contains all the logic of an event. Handles debouncing and
    # throttling.
    #
    # Vedeu provides an event mechanism to facilitate the
    # functionality of your application. The events are either Vedeu
    # defined, ie. system events or user defined, ie. user events.
    # User events allow you to orchestrate behaviour within your
    # application, ie. the user presses a specific key,
    # you trigger an event to make something happen. Eg. pressing 'p'
    # instructs the player to play.
    #
    # Events described here assume that you have bound the events
    # within your classes:
    #
    #   class SomeClassInYourApplication
    #     Vedeu.bind(:event_name) do |arg1, arg2|
    #       # Things that should happen when the event is triggered;
    #       # these can be method calls or the triggering of another
    #       # event or events.
    #     end
    #
    #     Vedeu.bind(:event_name) do
    #       # Not all events you define will have arguments; like
    #       # methods.
    #       :do_stuff
    #     end
    #
    # @api private
    #
    class Event

      include Vedeu::Repositories::Model

      class << self

        # Register an event by name with optional delay (throttling)
        # which when triggered will execute the code contained within
        # the passed block.
        #
        # @macro param_name
        # @param options [Hash<Symbol => void>] The options to
        #   register the event with.
        # @option options :delay [Integer|Float] Limits the execution
        #   of the triggered event to only execute when first
        #   triggered, with subsequent triggering being ignored until
        #   the delay has expired.
        # @option options :debounce [Integer|Float] Limits the
        #   execution of the triggered event to only execute once the
        #   debounce has expired. Subsequent triggers before debounce
        #   expiry are ignored.
        # @macro param_block
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
        #   0.0.....0.2.....0.4.....0.6.....0.8.....1.0.....1.2.....1.4.....1.6.
        #   .T...T...T...T...T...T...T...T...T...T...T...T...T...T...T...T...T..
        #   .X...i...i...i...i...X...i...i...i...i...X...i...i...i...i...i...i..
        #
        #   Vedeu.bind(:my_delayed_event, { delay: 0.5 })
        #     # ... some code here ...
        #   end
        #
        #   T = Triggered, X = Executed, i = Ignored.
        #
        #   0.0.....0.2.....0.4.....0.6.....0.8.....1.0.....1.2.....1.4.....1.6.
        #   .T...T...T...T...T...T...T...T...T...T...T...T...T...T...T...T...T..
        #   .i...i...i...i...i...i...i...X...i...i...i...i...i...i...X...i...i..
        #
        #   Vedeu.bind(:my_debounced_event, { debounce: 0.7 })
        #     # ... some code here ...
        #   end
        #
        # @return [Boolean]
        def bind(name, options = {}, &block)
          Vedeu.log(type: :event, message: "Binding: '#{name.inspect}'")

          new(name, block, options).bind
        end
        alias event bind
        alias register bind

        # {include:file:docs/dsl/by_method/bound.md}
        # @macro param_name
        # @return [Boolean]
        def bound?(name)
          Vedeu.events.registered?(name) ||
            Vedeu::Events::Aliases.registered?(name)
        end

        # {include:file:docs/dsl/by_method/unbind.md}
        # @macro param_name
        # @return [Boolean]
        def unbind(name)
          return false unless Vedeu.bound?(name)

          Vedeu.log(type:    :event,
                    message: "Unbinding: '#{name.inspect}'")

          Vedeu.events.remove(name)

          true
        end

        extend Forwardable

        def_delegators Vedeu::Events::Trigger,
                       :trigger

      end # Eigenclass

      # Returns a new instance of Vedeu::Events::Event.
      #
      # @param (see Vedeu::Events::Event.bind)
      # @return [Vedeu::Events::Event]
      def initialize(name, closure, options = {})
        @name         = name
        @options      = options
        @closure      = closure
        @deadline     = 0
        @executed_at  = 0
        @now          = 0
        @repository   = Vedeu.events
      end

      # @see Vedeu::Events::Event.bind
      def bind
        new_collection = if repository.registered?(name)
                           repository.find(name).add(self)

                         else
                           Vedeu::Events::Events.new([self], nil, name)

                         end

        repository.store(new_collection)

        true
      end

      # Triggers the event based on debouncing and throttling
      # conditions.
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
      # @macro return_name
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

        closure.call(*args)
      end

      # Returns a boolean indicating whether throttling is required
      # for this event. Setting the delay option to any value greater
      # than 0 will enable throttling.
      #
      # @return [Boolean]
      def throttling?
        @now = Vedeu.clock_time

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

      # Returns a boolean indicating whether debouncing is required
      # for this event. Setting the debounce option to any value
      # greater than 0 will enable debouncing.
      # Sets the deadline for when this event can be executed to a
      # point in the future determined by the amount of debounce time
      # left.
      #
      # @return [Boolean]
      def debouncing?
        @now = Vedeu.clock_time

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

      # Returns a boolean indicating whether this event has a
      # deadline.
      #
      # @return [Boolean]
      def deadline?
        @deadline > 0
      end

      # Return the amount of time in seconds to debounce the event by.
      #
      # @return [Integer|Float]
      def debounce
        options[:debounce] || defaults[:debounce]
      end

      # Return the amount of time in seconds to throttle the event by.
      #
      # @return [Integer|Float]
      def delay
        options[:delay] || defaults[:delay]
      end

      # Combines the options provided at instantiation with the
      # default values.
      #
      # @return [Hash<Symbol => void>]
      def options
        defaults.merge!(@options)
      end

      # @macro defaults_method
      def defaults
        {
          delay:      0.0,
          debounce:   0.0,
        }
      end

    end # Event

  end # Events

  # @api public
  # @!method bind
  #   @see Vedeu::Events::Event.bind
  # @api public
  # @!method bound?
  #   @see Vedeu::Events::Event.bound?
  # @api public
  # @!method unbind
  #   @see Vedeu::Events::Event.unbind
  def_delegators Vedeu::Events::Event,
                 :bind,
                 :bound?,
                 :unbind

  # :nocov:

  # See {file:docs/events/system.md#\_log_}
  Vedeu.bind(:_log_) { |msg| Vedeu.log(type: :debug, message: msg) }

  # :nocov:

end # Vedeu
