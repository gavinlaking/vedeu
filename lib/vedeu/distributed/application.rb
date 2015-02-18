require 'drb'

module Vedeu

  module Distributed

    # Orchestrates the running of the main application loop via the DRb server.
    #
    # @example
    #   app = Vedeu::Distributed::Application.start(configuration)
    #   app.input('a')
    #   app.output # => some output
    #   app.stop
    #
    # @api private
    class Application

      class << self

        def start(configuration)
          new(configuration).start
        end

      end

      def initialize(configuration)
        @configuration = configuration

        # $SAFE = 1 # stop eval and friends
      end

      def start
        DRb.start_service(uri, self)

        Vedeu.bind(:_output_) { |data| self.output(data) }

        self
      end

      def input(data)
        Vedeu.trigger(:_keypress_, data)
      end
      alias_method :read, :input

      # we need a way to collect the output generated, mix that with a virtual
      # terminal of predefined size, render, and return that as the output.
      def output(data = nil)
        data
      end
      alias_method :write, :output

      def stop
        DRb.stop_service
        DRb.thread.join
      end

      private

      attr_reader :configuration

      # @return [String]
      def uri
        Vedeu::Distributed::Uri.new(configuration.drb_host,
                                    configuration.drb_port).to_s
      end

    end # Application

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
