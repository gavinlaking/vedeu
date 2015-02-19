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

        # @param configuration [Vedeu::Configuration]
        # @return []
        def start(configuration)
          new(configuration).start
        end

      end

      # @param configuration [Vedeu::Configuration]
      # @return []
      def initialize(configuration)
        @configuration = configuration

        # $SAFE = 1 # stop eval and friends
      end

      # @return []
      def start
        Vedeu.bind(:_output_) { |data| self.output(data) }

        Vedeu.log("Started distributed server: '#{uri}'")

        DRb.start_service(uri, self)

        self
      end

      # @param data []
      # @return []
      def input(data)
        Vedeu.log("<<< DRb Input")

        Vedeu.trigger(:_keypress_, data)
      end
      alias_method :read, :input

      # @param data []
      # @return []
      def output(data = nil)
        Vedeu.log(">>> DRb Output")

        data
      end
      alias_method :write, :output

      # @return []
      def stop
        Vedeu.log("Stopping distributed server: '#{uri}'")

        DRb.stop_service

        DRb.thread.join
      rescue NoMethodError # raised when #join is called on NilClass.
        # ...

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
