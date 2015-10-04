module Vedeu

  module Events

    # Allows the storing of event aliases. Each alias can contain
    # multiple event names.
    #
    module Aliases

      include Vedeu::Common
      extend self

      # Add events by name to the alias name group. When an alias is
      # triggered, all the events stored in the group are also
      # triggered.
      #
      # @example
      #   Vedeu.bind_alias(alias_name, event_name)
      #
      # @param alias_name [Symbol] The name of the alias. This can
      #   represent a single event or group of events.
      # @param event_name [Symbol] The name of the event to bind to
      #   the alias. When the alias is triggered, all events bound
      #   will also be triggered.
      # @return [Hash<Symbol => Array<Symbol>>]
      def bind_alias(alias_name, event_name)
        storage[alias_name] << event_name
      end
      alias_method :add, :bind_alias

      # Return a boolean indicating whether the storage is empty.
      #
      # @return [Boolean]
      def empty?
        storage.empty?
      end

      # @param alias_name [Symbol]
      # @return [Array<Symbol>]
      def find(alias_name)
        storage[alias_name]
      end

      # Returns a boolean indicating whether the alias is registered.
      #
      # @param alias_name [Symbol]
      # @return [Boolean]
      def registered?(alias_name)
        return false if empty? || absent?(alias_name)

        storage.include?(alias_name)
      end

      # Remove an alias by name. The alias name group is destroyed,
      #   but events stored within this alias are not.
      #
      # @example
      #   Vedeu.unbind_alias(alias_name)
      #
      # @param alias_name [Symbol] The name of the alias.
      # @return [FalseClass|Hash<Symbol => Array<Symbol>>]
      def unbind_alias(alias_name)
        return false if empty?
        return false unless registered?(alias_name)

        storage.delete(alias_name)
        storage
      end
      alias_method :remove, :unbind_alias

      # @return [Hash<Symbol => Array<Symbol>>]
      def reset
        @storage = in_memory
      end
      alias_method :reset!, :reset

      # Access to the storage for this repository.
      #
      # @return [Hash<Symbol => Array<Symbol>>]
      def storage
        @storage ||= in_memory
      end

      # @param alias_name [Symbol]
      # @param args [void]
      # @return [FalseClass|Array<void>|void]
      def trigger(alias_name, *args)
        return [] unless registered?(alias_name)

        find(alias_name).map do |event_name|
          Vedeu.log(type: :debug, message: "#{event_name}".freeze)
          Vedeu::Events::Trigger.trigger(event_name, *args)
        end
      end

      private

      # @return [Hash<Symbol => Array<Symbol>>]
      def in_memory
        Hash.new { |hash, key| hash[key] = [] }
      end

    end # Aliases

  end # Events

  # @!method bind_alias
  #   @see Vedeu::Events::Aliases#bind_alias
  # @!method unbind_alias
  #   @see Vedeu::Events::Aliases#unbind_alias
  def_delegators Vedeu::Events::Aliases, :bind_alias, :unbind_alias

end # Vedeu
