require 'drb'
require 'singleton'

module Vedeu

  module Distributed

    # A class for the server side of the DRb server/client relationship.
    #
    # @api private
    #
    class Server

      $SAFE = 1 # disable `eval` and related calls on strings passed

      include Singleton

      # @param data [String|Symbol]
      # @return []
      def self.input(data)
        instance.input(data)
      end

      # @return []
      def self.output
        instance.output
      end

      # @return []
      def self.restart
        instance.restart
      end

      # When called will stop the DRb server and attempt to terminate the client
      # application.
      #
      # @return []
      def self.shutdown
        instance.shutdown
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

      # @param data [String|Symbol]
      # @return []
      def input(data)
        Vedeu.log(type: :drb, message: "<<< input")

        Vedeu.trigger(:_keypress_, data)
      end
      alias_method :read, :input

      # @return []
      def output
        Vedeu.log(type: :drb, message: ">>> output")

        Vedeu.trigger(:_drb_retrieve_output_)
      end
      alias_method :write, :output

      # @return []
      def restart
        if drb_running?
          Vedeu.log(type: :drb, message: "Restarting: '#{uri}'")

          stop

          start

        else
          Vedeu.log(type: :drb, message: "Not running")

          start

        end
      end

      # @note
      #   :_exit_ never gets triggered as when the DRb server goes away, no
      #   further methods will be called.
      #
      # @return []
      def shutdown
        if drb_running?
          stop

        end

        Vedeu.trigger(:_exit_)
      end

      # @return [Vedeu::Distributed::Server]
      def start
        if drb?
          if drb_running?
            Vedeu.log(type: :drb, message: "Already started: '#{uri}'")

          else
            Vedeu.log(type: :drb, message: "Starting: '#{uri}'")

            DRb.start_service(uri, self)

            # DRb.thread.join # not convinced this is needed here
          end
        else
          Vedeu.log(type: :drb, message: "Not enabled")

        end
      end

      # @return [Symbol]
      def status
        if drb_running?
          Vedeu.log(type: :drb, message: "Running")

          :running

        else
          Vedeu.log(type: :drb, message: "Stopped")

          :stopped

        end
      end

      # @return []
      def stop
        if drb?
          if drb_running?
            Vedeu.log(type: :drb, message: "Stopping: '#{uri}'")

            DRb.stop_service

            DRb.thread.join

          else
            Vedeu.log(type: :drb, message: "Already stopped: '#{uri}'")

          end
        else
          Vedeu.log(type: :drb, message: "Not enabled")

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
