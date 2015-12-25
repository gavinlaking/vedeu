# frozen_string_literal: true

module Vedeu

  module Runtime

    # Orchestrates the running of the main application loop.
    #
    class Application

      class << self

        # @param (see #initialize)
        def start(configuration)
          new(configuration).start
        end

        # @param (see #initialize)
        def restart(configuration)
          new(configuration).start
        end

        # Stops the application! - The `:_cleanup_` event is
        # triggered, which in turn triggers the client event
        # `:cleanup`; the client application may treat this event as
        # Vedeu signalling that it is about to terminate. Client
        # applications are encouraged to use this event to close any
        # open buffers, save files, empty trash, etc.
        #
        # @example
        #   Vedeu.exit
        #
        # @return [void]
        def stop
          Vedeu.trigger(:_cleanup_)

          Vedeu::Runtime::MainLoop.stop!
        end
        alias_method :exit, :stop

      end # Eigenclass

      # :nocov:

      # Returns a new instance of Vedeu::Runtime::Application.
      #
      # @param configuration [Vedeu::Configuration]
      # @return [Vedeu::Runtime::Application]
      def initialize(configuration = Vedeu::Configuration)
        @configuration = configuration
      end

      # Starts the application!
      #
      # - A new terminal screen is opened (or rather the current
      #   terminal is requested into either :raw or :cooked mode).
      # - The cursor visibility is then set dependent on this mode.
      #   In :raw mode, the cursor is hidden.
      # - The `:_initialize_` event is triggered. The client
      #   application is may treat this event as Vedeu signalling that
      #   it is now ready.
      # - We enter into the main sequence where the application will
      #   either run once or continuous, interactively or standalone.
      #
      # @return [Array] The last output sent to the terminal.
      def start
        Vedeu.trigger(:_drb_start_)

        Vedeu::Terminal.open do
          Vedeu::Terminal.set_cursor_mode

          Vedeu.trigger(:_initialize_)

          runner { main_sequence }
        end
      end

      protected

      # @!attribute [r] configuration
      # @return [Vedeu::Configuration]
      attr_reader :configuration

      private

      # Runs the application loop either once, or forever (exceptions
      # and signals permitting).
      #
      # @param block [Proc]
      # @return [void]
      def runner(&block)
        return yield if configuration.once?

        run_many { yield }
      end

      # For an interactive application we capture input, (usually from
      # the user), and continue the main loop. If the client
      # application does not require user input then Vedeu triggers
      # the `:_standalone_` event for each run of the main loop. The
      # client application is expected to respond to this event and
      # 'do something useful'. When the client application has
      # finished, it should trigger the `:_exit_` event.
      #
      # @return [void]
      def main_sequence
        if configuration.interactive?
          Vedeu::Input::Capture.read

        else
          Vedeu.trigger(:_standalone_)
          Vedeu.refresh

        end
      end

      # Runs the application in a continuous loop. This loop is
      # stopped when an uncaught exception occurs or when either the
      # `:_mode_switch_` or `:_exit_` event is triggered.
      #
      # @param block [Proc]
      # @return [void]
      def run_many(&block)
        Vedeu::Runtime::MainLoop.start! { yield }

      rescue Vedeu::Error::ModeSwitch
        Vedeu::Runtime::Application.restart(Vedeu::Configuration)
      end

      # :nocov:

    end # Application

  end # Runtime

  # @!method exit
  #   @see Vedeu::Runtime::Application.stop
  def_delegators Vedeu::Runtime::Application,
                 :exit

  # :nocov:

  # See {file:docs/events/system.md#\_exit_}
  Vedeu.bind(:_exit_) { Vedeu.exit }

  # See {file:docs/events/system.md#\_mode_switch_}
  Vedeu.bind(:_mode_switch_) do |mode|
    Vedeu::Runtime::MainLoop.mode_switch!(mode)
  end

  # See {file:docs/events/system.md#\_cleanup_}
  Vedeu.bind(:_cleanup_) do
    Vedeu.trigger(:_drb_stop_)
    Vedeu.trigger(:cleanup)
  end

  # :nocov:

end # Vedeu
