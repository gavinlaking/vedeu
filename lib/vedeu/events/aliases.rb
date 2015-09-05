module Vedeu

  module Events

    # Allows the storing of event aliases. Each alias can contain multiple event
    # names.
    #
    module Aliases

      extend self

      # @param alias_name [Symbol]
      # @param event_name [Symbol]
      # @return [Hash<Symbol => Array<Symbol>>]
      def add(alias_name, event_name)
        storage[alias_name] << event_name
      end
      alias_method :bind_alias, :add

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
        return false if alias_name.nil? || alias_name.empty?
        return false if empty?

        storage.include?(alias_name)
      end

      # @param alias_name [Symbol]
      # @return [FalseClass|Hash<Symbol => Array<Symbol>>]
      def remove(alias_name)
        return false if empty?
        return false unless registered?(alias_name)

        storage.delete(alias_name)
        storage
      end
      alias_method :unbind_alias, :remove

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

        storage[alias_name].map do |event_name|
          Vedeu.log(type: :debug, message: "#{event_name}")
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

end # Vedeu
