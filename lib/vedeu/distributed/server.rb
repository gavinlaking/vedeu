require 'drb'
require 'singleton'

module Vedeu

  module Distributed

    # Orchestrates the running of the main application loop via the DRb server.
    #
    # @example
    #   app = Vedeu::Distributed::Server.start(configuration)
    #   app.input('a')
    #   app.output # => some output
    #   app.stop
    #
    # @api private
    #
    class Server

      include Singleton

      # @param data [String|Symbol]
      # @return []
      def self.input(data)
        instance.input(data)
      end

      # @param data [String]
      # @return []
      def self.output(data)
        instance.output(data)
      end

      # @return []
      def self.restart
        instance.restart
      end

      # @return []
      def self.start
        instance.start
      end

      # @return [Symbol]
      def self.status
        instance.status
      end

      # @return []
      def self.stop
        instance.stop
      end

      # @return []
      def restart
        if drb_running?
          Vedeu.drb_log("Restarting: '#{uri}'")

          stop

          start

        else
          Vedeu.drb_log("Not running")

          start

        end
      end

      # @return [Vedeu::Distributed::Server]
      def start
        if drb?
          if drb_running?
            Vedeu.drb_log("Already started: '#{uri}'")

          else
            Vedeu.drb_log("Starting: '#{uri}'")

            DRb.start_service(uri, self)
          end
        else
          Vedeu.drb_log("Not enabled")

        end
      end

      # @return [Symbol]
      def status
        if drb_running?
          Vedeu.drb_log("Running")

          :running

        else
          Vedeu.drb_log("Stopped")

          :stopped

        end
      end

      # @param data [String|Symbol]
      # @return []
      def input(data)
        Vedeu.drb_log("<<< input")

        Vedeu.trigger(:_keypress_, data)
      end
      alias_method :read, :input

      # @return []
      def output
        Vedeu.drb_log(">>> output")

      end
      alias_method :write, :output

      # @return []
      def stop
        if drb?
          if drb_running?
            Vedeu.drb_log("Stopping: '#{uri}'")

            DRb.stop_service

            DRb.thread.join

          else
            Vedeu.drb_log("Already stopped: '#{uri}'")

          end
        else
          Vedeu.drb_log("Not enabled")

        end
      rescue NoMethodError # raised when #join is called on NilClass.
        # ...

      end

      private

      attr_reader :configuration

      # @return [Boolean]
      def drb?
        Vedeu::Configuration.drb?
      end

      # @return [String]
      def drb_host
        Vedeu::Configuration.drb_host
      end

      # @return [|NilClass]
      def drb_running?
        DRb.thread
      end

      # @return [Fixnum|String]
      def drb_port
        Vedeu::Configuration.drb_port
      end

      # @return [String]
      def uri
        Vedeu::Distributed::Uri.new(drb_host, drb_port).to_s
      end

    end # Server

  end # Distributed

end # Vedeu
