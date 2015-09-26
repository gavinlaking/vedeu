module Vedeu

  module Buffers

    # Refreshes the given named interface.
    #
    # @example
    #   Vedeu.trigger(:_refresh_view_, name)
    #
    class Refresh

      include Vedeu::Common

      # @param name [String] The name of the interface to be refreshed
      #   using the named buffer.
      # @return [Array|Vedeu::Error::ModelNotFound]
      def self.by_name(name)
        new(name).by_name
      end

      # Return a new instance of Vedeu::Buffers::Refresh.
      #
      # @param name [String]
      # @return [Vedeu::Buffers::Refresh]
      def initialize(name)
        @name = name
      end

      # @return [void]
      def by_name
        Vedeu.timer("Refresh Buffer: '#{buffer_name}'") do
          Vedeu.buffers.by_name(buffer_name).render
        end if Vedeu.ready?
      end

      protected

      # # @!attribute [r] name
      # @return [String]
      attr_reader :name

      private

      # @raise [Vedeu::Error::MissingRequired] When the name is empty
      #   or nil.
      # @return [String]
      def buffer_name
        return name if present?(name)

        fail Vedeu::Error::MissingRequired,
             'Cannot refresh interface with an empty interface name.'
      end

    end # Refresh

  end # Buffers

end # Vedeu
