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

# require 'drb'
# URI = "druby://127.0.0.1:12345"
# LOG_FILE = 'mylog.log'
# class LogService
#   def write_to_logfile(msg)
#     puts msg
#     File.open(LOG_FILE, 'a') {|file| file.write(msg)}
#   end
#   def shutdown_server
#     DRb.stop_service
#   end
# end
# DRb.start_service(URI, LogService.new)
# DRb.thread.join
# puts 'server has stopped.'
