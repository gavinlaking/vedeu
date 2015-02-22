module Vedeu

  class MainLoop

    trap('SIGTERM') { stop! }
    trap('TERM')    { stop! }
    trap('INT')     { stop! }

    def self.start!(&block)
      @started = true
      @loop    = true

      while(@loop) do
        Vedeu.trigger(:_tick_)

        yield

        safe_exit_point!
      end
    end

    def self.stop!
      @loop = false
    end

    def self.safe_exit_point!
      if @started && !@loop
        raise Interrupt
      end
    end

  end # MainLoop

  # Orchestrates the running of the main application loop.
  #
  # @api private
  #
  class Application

    class << self

      # @return []
      def start(configuration)
        new(configuration).start
      end
      alias_method :restart, :start

      # Stops the application!
      # - The `:_cleanup_` event is triggered, which in turn triggers the client
      #   event `:cleanup`; the client application may treat this event as Vedeu
      #   signalling that it is about to terminate. Client applications are
      #   encouraged to use this event to close any open buffers, save files,
      #   empty trash, etc.
      #
      # @raise [StopIteration] Will cause {#start} to exit its loop and
      #   terminate the application.
      # @return [StopIteration]
      def stop
        Vedeu.trigger(:_cleanup_)

        # fail StopIteration
        Vedeu::MainLoop.stop!
      end

    end # Application eigenclass

    # :nocov:

    # @return [Application]
    def initialize(configuration)
      @configuration = configuration
    end

    # Starts the application!
    # - A new terminal screen is opened (or rather the current terminal is
    #   requested into either :raw or :cooked mode).
    # - The cursor visibility is then set dependent on this mode. In :raw mode,
    #   the cursor is hidden.
    # - The `:_initialize_` event is triggered. The client application is
    #   may treat this event as Vedeu signalling that it is now ready.
    # - We enter into the main sequence where the application will either run
    #   once or continuous, interactively or standalone.
    #
    # @return [Array] The last output sent to the terminal.
    def start
      Vedeu.trigger(:_drb_start_)

      output = Terminal.open do
        Terminal.set_cursor_mode

        Vedeu.trigger(:_initialize_)

        runner { main_sequence }
      end

      Vedeu.trigger(:_drb_stop_, 'via Vedeu::Application#start')

      output
    end

    private

    attr_reader :configuration

    # Runs the application loop either once, or forever (exceptions and signals
    # permitting).
    #
    # @return []
    def runner
      if configuration.once?
        yield

      else
        run_many { yield }

      end
    end

    # For an interactive application we capture input, (usually from the user),
    # and continue the main loop. If the client application does not require
    # user input then Vedeu triggers the `:_standalone_` event for each run of
    # the main loop. The client application is expected to respond to this event
    # and 'do something useful'. When the client application has finished, it
    # should trigger the `:_exit_` event.
    #
    # @return []
    def main_sequence
      if configuration.interactive?
        Input.capture(Terminal)

      else
        Vedeu.trigger(:_standalone_)

      end
    end

    # Runs the application in a continuous loop. This loop is stopped when an
    # uncaught exception occurs or when either the `:_mode_switch_` or `:_exit_`
    # event is triggered.
    #
    # @return []
    def run_many
      MainLoop.start! { yield }

    rescue ModeSwitch
      Terminal.switch_mode!

      Vedeu.trigger(:_drb_restart_)

      Application.restart

    end

    # :nocov:

  end # Application

end # Vedeu
