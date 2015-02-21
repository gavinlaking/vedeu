require 'drb'

module Vedeu

  module Distributed

    # @example
    #   client = Vedeu::Distributed::Client.new("druby://localhost:21420")
    #   client.input('a')
    #   client.output # => 'some content...'
    #
    class Client

      # @param uri [String]
      # @return [Client]
      def self.connect(uri)
        new(uri)
      end

      # @param uri [String]
      # @return [Client]
      def initialize(uri)
        @uri = uri.to_s
      end

      # Send input to the DRb server.
      #
      # @param data [String|Symbol]
      # @return []
      def input(data)
        server.input(data)

      rescue DRb::DRbConnError
        puts "Could not connect to DRb server."

      end
      alias_method :read, :input

      # Fetch output from the DRb server.
      #
      # @return []
      def output
        server.output

      rescue DRb::DRbConnError
        puts "Could not connect to DRb server."

      end
      alias_method :write, :output

      private

      attr_reader :uri

      # @return []
      def server
        @server ||= DRbObject.new_with_uri(uri)
      end

    end # Client

  end # Distributed

end # Vedeu
