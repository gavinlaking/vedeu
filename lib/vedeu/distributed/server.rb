module Vedeu

  module Distributed

    # Value class which provides the host and port for the DRb server and
    # client.
    class Uri

      attr_reader :host, :port

      # @param host [String]
      # @param port [Fixnum|String]
      # @return [Uri]
      def initialize(host, port)
        @host    = host     || 'druby://localhost'
        @port    = port     || 21420
      end

      # @return [String] The host and port as a single value.
      def to_s
        [host, port].join(':')
      end

    end # Uri

    class Server

      attr_reader :uri, :service

      # @param uri     [String]
      # @param service [Object]
      # @return [Server]
      def initialize(uri, service)
        @uri     = uri
        @service = service

        # $SAFE    = 1 # stop eval and friends
      end

      def start
        DRb.start_service(uri, service) if service
      end

      def stop
        DRb.thread.join
      end

    end # Server

    class Client

      # @param uri [String]
      def self.connect(uri)
        new(uri).connect
      end

      # @param uri [String]
      # @return [Client]
      def initialize(uri)
        @uri = uri.to_s
      end

      def connect
        DRbObject.new_with_uri(uri)
      end

      def disconnect
        DRb.stop_service
      end

      private

      attr_reader :uri

    end # Client

  end # Distributed

end # Vedeu
