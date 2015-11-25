module Vedeu

  module Output

    module CompressorCache

      extend self

      # @param key [NilClass|Symbol]
      # @return [Array<void>]
      def read(key)
        storage.fetch(key, [])
      end

      # @return [Hash<Symbol => Array<void>>]
      def reset!
        @storage = in_memory
      end
      alias_method :reset, :reset!

      # @return [Hash<Symbol => Array<void>>]
      def storage
        @storage ||= in_memory
      end

      # @param key [NilClass|Symbol]
      # @param value [Array|NilClass]
      # @return [Hash<Symbol => Array<void>>]
      def write(key, value)
        return storage if invalid_key?(key) || invalid_value?(value)

        storage.merge!(key => value)
      end

      private

      # @return [Hash<Symbol => Array<void>>]
      def in_memory
        {
          compressed: '',
          original:   [],
        }
      end

      # @param key [NilClass|Symbol]
      # @return [Boolean]
      def invalid_key?(key)
        key.nil? || !in_memory.keys.include?(key)
      end

      # @param value [Array|NilClass]
      # @return [Boolean]
      def invalid_value?(value)
        value.nil? || value.empty?
      end

    end # CompressorCache

  end # Output

end # Vedeu
