module Vedeu

  module Distributed

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

  end # Distributed

end # Vedeu
