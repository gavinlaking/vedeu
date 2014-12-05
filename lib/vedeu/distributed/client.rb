module Vedeu

  module Distributed

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
