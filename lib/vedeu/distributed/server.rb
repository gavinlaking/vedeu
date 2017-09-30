# frozen_string_literal: true

module Vedeu

  # Provides a mechanism to control a running client application via
  # DRb.
  #
  module Distributed

    # A class for the server side of the DRb server/client
    # relationship.
    #
    # @api private
    #
    class Server

      $SAFE = 0 # disable `eval` and related calls on strings passed

      include Singleton

      class << self

        # @param (see #input)
        # @see #input
        def input(data, type = :key)
          instance.input(data, type)
        end

        # @return [void]
        # @see #output
        def output
          instance.output
        end

        # @return [void]
        # @see #restart
        def restart
          instance.restart
        end
        alias drb_restart restart

        # @return [void]
        # @see #shutdown
        def shutdown
          instance.shutdown
        end

        # @return [void]
        # @see #start
        def start
          instance.start
        end
        alias drb_start start

        # @return [Symbol]
        # @see #status
        def status
          instance.status
        end
        alias drb_status status

        # @return [void]
        # @see #stop
        def stop
          instance.stop
        end
        alias drb_stop stop

      end # Eigenclass

      # @param data [String|Symbol] The input to send to Vedeu.
      # @param type [Symbol] Either :command or :keypress. Will
      #   trigger the respective capture mode within
      #   {Vedeu::Input::Input}, or if not given, will treat the data
      #   as a keypress.
      # @return [void]
      def input(data, type = :keypress)
        Vedeu.trigger(:_drb_input_, data, type)
      end
      alias read input

      # @return [void]
      def output
        Vedeu.trigger(:_drb_retrieve_output_)
      end
      alias write output

      # @return [Fixnum] The PID of the currently running application.
      def pid
        Process.pid
      end

      # Restart the DRb server.
      #
      # @example
      #   Vedeu.drb_restart
      #
      # @return [void]
      def restart
        log('Attempting to restart')

        return not_enabled unless Vedeu.config.drb?

        if drb_running?
          log('Restarting')

          stop

        else
          log('Not running')

        end

        start
      end

      # When called will stop the DRb server and attempt to terminate
      # the client application.
      #
      # @note
      #   :_exit_ never gets triggered as when the DRb server goes
      #   away, no further methods will be called.
      #
      # @return [void]
      def shutdown
        return not_enabled unless Vedeu.config.drb?

        stop if drb_running?

        Vedeu.trigger(:_exit_)

        Vedeu::Terminal.restore_screen
      end

      # Start the DRb server.
      #
      # @example
      #   Vedeu.drb_start
      #
      # @return [Vedeu::Distributed::Server]
      def start
        log('Attempting to start')

        return not_enabled unless Vedeu.config.drb?

        if drb_running?
          log('Already started')

        else
          log('Starting')

          DRb.start_service(uri, self)

          # DRb.thread.join # not convinced this is needed here
        end
      end

      # Fetch the status of the DRb server.
      #
      # @example
      #   Vedeu.drb_status
      #
      # @return [Symbol]
      def status
        log('Fetching status')

        return not_enabled unless Vedeu.config.drb?

        if drb_running?
          log('Running')

          :running

        else
          log('Stopped')

          :stopped

        end
      end

      # Stop the DRb server.
      #
      # @example
      #   Vedeu.drb_stop
      #
      # @return [void]
      def stop
        log('Attempting to stop')

        return not_enabled unless Vedeu.config.drb?

        if drb_running?
          log('Stopping')

          DRb.stop_service

          DRb.thread.join

        else
          log('Already stopped')

        end
      rescue NoMethodError # raised when #join is called on NilClass.
        Vedeu.log(type:    :drb,
                  message: 'Attempted to #join on DRb.thread.')
      end

      protected

      # @!attribute [r] configuration
      # @return [Vedeu::Configuration]
      attr_reader :configuration

      private

      # @return [|NilClass]
      def drb_running?
        DRb.thread
      end

      # @return [void]
      def log(message)
        Vedeu.log(type: :drb, message: "#{message}: '#{uri}'")
      end

      # @return [Symbol]
      def not_enabled
        log('Not enabled')

        :drb_not_enabled
      end

      # @return [String]
      def uri
        Vedeu::Distributed::Uri.new(Vedeu.config.drb_host,
                                    Vedeu.config.drb_port).to_s
      end

    end # Server

  end # Distributed

  # @api public
  # @!method drb_restart
  #   @see Vedeu::Distributed::Server#restart
  # @api public
  # @!method drb_start
  #   @see Vedeu::Distributed::Server#start
  # @api public
  # @!method drb_status
  #   @see Vedeu::Distributed::Server#status
  # @api public
  # @!method drb_stop
  #   @see Vedeu::Distributed::Server#stop
  def_delegators Vedeu::Distributed::Server,
                 :drb_restart,
                 :drb_start,
                 :drb_status,
                 :drb_stop

end # Vedeu
