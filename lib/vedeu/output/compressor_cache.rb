# frozen_string_literal: true

module Vedeu

  module Output

    # Store a copy of the data last processed by
    # {Vedeu::Output::Compressor}. Both the original content and the
    # compressed versions are kept (unless modified) to speed up the
    # rendering of the display.
    #
    # @api private
    #
    module CompressorCache

      extend self
      extend Vedeu::Repositories::Storage

      # @param key [NilClass|Symbol]
      # @return [Array<void>]
      def read(key)
        storage.fetch(key, [])
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
