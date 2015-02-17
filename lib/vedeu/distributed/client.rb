require 'drb'

module Vedeu

  module Distributed

    class Client

      # @param uri [String]
      # @return [Client]
      def initialize(uri)
        @uri = uri.to_s
      end

      def input(data)
        server.input(data)
      end
      alias_method :read, :input

      def output
        server.output
      end
      alias_method :write, :output

      def start
        # client should be able to start a server, but what if one already
        # exists?
      end

      def stop
        server.stop
      end

      private

      attr_reader :uri

      def server
        @server ||= DRbObject.new_with_uri(uri)
      end

    end # Client

  end # Distributed

end # Vedeu
