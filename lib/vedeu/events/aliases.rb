# frozen_string_literal: true

module Vedeu

  module Events

    # Allows the storing of event aliases. Each alias can contain
    # multiple event names.
    #
    module Aliases

      include Vedeu::Common
      extend self
      extend Vedeu::Repositories::Storage

      # {include:file:docs/dsl/by_method/bind_alias.md}
      # @param alias_name [Symbol] The name of the alias. This can
      #   represent a single event or group of events.
      # @param event_name [Symbol] The name of the event to bind to
      #   the alias. When the alias is triggered, all events bound
      #   will also be triggered.
      # @return [Hash<Symbol => Array<Symbol>>]
      def bind_alias(alias_name, event_name)
        storage[alias_name] << event_name
      end
      alias add bind_alias

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

      # {include:file:docs/dsl/by_method/unbind_alias.md}
      # @param alias_name [Symbol] The name of the alias.
      # @return [Boolean|Hash<Symbol => Array<Symbol>>]
      def unbind_alias(alias_name)
        return false if empty?
        return false unless registered?(alias_name)

        storage.delete(alias_name)
        storage
      end
      alias remove unbind_alias

      # @param alias_name [Symbol]
      # @param args [void]
      # @return [Boolean|Array<void>|void]
      def trigger(alias_name, *args)
        return [] unless registered?(alias_name)

        find(alias_name).map do |event_name|
          Vedeu.log(type:    :event,
                    message: "Triggering: '#{event_name}' from alias " \
                             "'#{alias_name}'")
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

  # @api public
  # @!method bind_alias
  #   @see Vedeu::Events::Aliases#bind_alias
  # @api public
  # @!method unbind_alias
  #   @see Vedeu::Events::Aliases#unbind_alias
  def_delegators Vedeu::Events::Aliases,
                 :bind_alias,
                 :unbind_alias

end # Vedeu
