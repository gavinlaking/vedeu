# frozen_string_literal: true

module Vedeu

  module Repositories

    # Provides behaviour for resetting and accessing the storage of
    # various repositories.
    #
    # @api private
    #
    module Storage

      extend self

      # Remove all currently stored data for this repository.
      #
      # @return [void]
      def reset!
        Vedeu.log(type:    :reset,
                  message: "Resetting repository '#{self.class.name}'")

        @storage = in_memory
      end
      alias reset reset!

      # Return whole repository; provides raw access to the storage
      # for this repository.
      #
      # @return [void]
      def storage
        @storage ||= in_memory
      end
      alias all storage

    end # Storage

  end # Repositories

end # Vedeu
