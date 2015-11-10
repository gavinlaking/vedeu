module Vedeu

  module Events

    # Trigger a registered or system event by name with arguments. If
    # the event stored returns a value, that is returned. If multiple
    # events are registered for a name, then the result of each event
    # will be returned as part of a collection.
    #
    class Trigger

      # Trigger an event by name.
      #
      # @example
      #   Vedeu.trigger(:my_event, :oxidize, 'nitrogen')
      #
      # @param (see #initialize)
      # @return [Array]
      def self.trigger(name, *args)
        new(name, *args).trigger
      end

      # Returns a new instance of Vedeu::Events::Trigger.
      #
      # @param name [Symbol] The name of the event you wish to
      #   trigger. The event does not have to exist.
      # @param args [Array] Any arguments the event needs to execute
      #   correctly.
      # @return [Vedeu::Events::Trigger]
      def initialize(name, *args)
        @name = name
        @args = args
        @repository = Vedeu.events
      end

      # Trigger the event and return the result or an array of
      # results.
      #
      # @return [Array]
      def trigger
        Vedeu.log(type:    :event,
                  message: "No action for: '#{name.inspect}'") if results.empty?

        return results[0] if results.one?

        results
      end

      protected

      # @!attribute [r] name
      # @return [Symbol]
      attr_reader :name

      # @!attribute [r] args
      # @return [Array]
      attr_reader :args

      # @!attribute [r]
      # @return [Vedeu::Repositories::Repository]
      attr_reader :repository

      private

      # @return [Array<void>|void]
      def results
        @results ||= registered_events.map { |event| event.trigger(*args) }
      end

      # Return all of the registered events for this name.
      #
      # @return [Array|Array<Vedeu::Events::Event>]
      def registered_events
        return repository.find(name) if repository.registered?(name)

        Vedeu::Events::Aliases.find(name).map do |event_name|
          Vedeu::Events::Trigger.trigger(event_name, *args)
        end

        []
      end

    end # Trigger

  end # Events

  # @!method trigger
  #   @see Vedeu::Events::Trigger.trigger
  def_delegators Vedeu::Events::Trigger,
                 :trigger

end # Vedeu
