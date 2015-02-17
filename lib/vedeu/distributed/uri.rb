module Vedeu

  module Distributed

    # Value class which provides the host and port for the DRb server and
    # client.
    class Uri

      attr_reader :host, :port

      # @param host [String]
      # @param port [Fixnum|String]
      # @return [Uri]
      def initialize(host = 'druby://localhost', port = 21420)
        @host = host || 'druby://localhost'
        @port = port || 21420
      end

      # @return [String] The host and port as a single value.
      def to_s
        [host, port].join(':')
      end

    end # Uri

  end # Distributed

end # Vedeu
