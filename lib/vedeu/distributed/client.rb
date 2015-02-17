require 'drb'

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

# client.rb
# require 'drb'
# URI = "druby://127.0.0.1:12345"
# log_server = DRbObject.new_with_uri(URI)
# 5.times do |x|
#   log_server.write_to_logfile("The time is: #{Time.now}\n")
#   sleep 1
# end
# log_server.shutdown_server
