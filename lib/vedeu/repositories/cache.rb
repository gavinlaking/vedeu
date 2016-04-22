# frozen_string_literal: true

module Vedeu

  module Repositories

    # @api private
    #
    class Cache

      # @return [Vedeu::Repositories::Cache]
      def initialize
        @cache ||= {}
        @lock  = Mutex.new
      end

      # Add a new resource to the cache.
      #
      # @param resource [void]
      # @param options [Hash]
      # @option options value [void] The value to be cached.
      # @option options expires [Fixnum] The number of seconds after
      #   which the resource will have expired.
      # @return [void]
      def add(resource, options = {})
        value   = options[:value]
        expires = options.fetch(:expires, 600)

        @lock.synchronize do
          @cache[resource] = {
            value:      value,
            expires_at: (Time.now + expires),
          }
        end
      end

      # Remove all cached resources.
      #
      # @return [Hash]
      def clear
        @cache = {}
      end

      # Read the cached resource if it exists.
      #
      # @param resource [void]
      # @return [void]
      def read(resource)
        resource = @cache[resource]

        return unless resource
        return if resource[:expires_at] < Time.now

        resource[:value]
      end

      # Remove the cached resource if it exists.
      #
      # @param resource [void]
      # @return [Boolean]
      def remove(resource)
        if @cache.key?(resource)
          @cache.delete(resource)
          true

        else
          false

        end
      end

    end # Cache

  end # Repositories

end # Vedeu
