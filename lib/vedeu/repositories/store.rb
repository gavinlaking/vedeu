# frozen_string_literal: true

module Vedeu

  module Repositories

    # Provides generic repository related behaviour.
    #
    # @api private
    #
    module Store

      include Enumerable
      include Vedeu::Common
      include Vedeu::Repositories::Storage

      alias all storage
      alias clear reset!

      # @macro param_block
      # @return [Enumerator]
      def each(&block)
        storage.each(&block)
      end

      # Return a boolean indicating whether the storage is empty.
      #
      # @return [Boolean]
      def empty?
        storage.empty?
      end

      # Returns a boolean indicating whether the named model is
      # registered.
      #
      # @macro param_name
      # @return [Boolean]
      def exists?(name)
        return false if empty? || absent?(name)

        storage.include?(name)
      end
      alias registered? exists?

      # Returns a collection of the names of all the registered
      # entities.
      #
      # @return [Array]
      def registered
        return []           if empty?
        return storage.keys if hash?(storage)
        return storage.to_a if storage.is_a?(Set)

        storage
      end

      # Return the number of entries stored.
      #
      # @return [Fixnum]
      def size
        storage.size
      end

      # @return [Hash]
      def in_memory
        {}
      end

    end # Store

  end # Repositories

end # Vedeu
