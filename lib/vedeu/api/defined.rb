module Vedeu
  module API

    # Provides a set of helpful API methods to return information about various
    # registered subsystems.
    #
    # @api public
    module Defined

      extend self

      # Returns all events currently registered with Vedeu.
      #
      # @return [Array]
      def events
        Vedeu.events.registered
      end

      # Returns all groups currently registered with Vedeu.
      #
      # @return [Array]
      def groups
        Vedeu::Buffers.registered_groups
      end

      # Returns all interfaces currently registered with Vedeu.
      #
      # @return [Array]
      def interfaces
        Vedeu::Buffers.registered_interfaces
      end

    end
  end
end
