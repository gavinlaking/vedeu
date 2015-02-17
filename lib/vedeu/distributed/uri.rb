module Vedeu

  module Distributed

    # Value class which provides the host and port for the DRb server and
    # client.
    class Uri

      attr_reader :host, :port

      # @param host [String] Hostname or IP address.
      # @param port [Fixnum|String]
      # @return [Uri]
      def initialize(host = 'localhost', port = 21420)
        @host = host || 'localhost'
        @port = port || 21420
      end

      # @example
      #   'druby://localhost:21420'
      #
      # @return [String] The host and port as a single value.
      def to_s
        [scheme, host, ':', port].join
      end

      private

      def scheme
        'druby://'
      end

    end # Uri

  end # Distributed

end # Vedeu
