module Vedeu

  # Orchestrates the running of the main application loop.
  #
  # @api private
  class Application
    # :nocov:
    class << self

      # @return []
      def start
        new.start
      end
      alias_method :restart, :start

      # Stops the application!
      # - The `:_cleanup_` event is triggered. Vedeu does not handle this event;
      #   the client application may treat this event as Vedeu signalling that it
      #   is about to terminate. Client applications are encouraged to use this
      #   event to close any open buffers, save files, empty trash, etc.
      #
      # @raise [StopIteration] Will cause {#start} to exit its loop and
      #   terminate the application.
      # @return [StopIteration]
      def stop
        Vedeu.trigger(:_cleanup_)

        fail StopIteration
      end
    end

    # @return [Application]
    def initialize; end

    # Starts the application!
    # - A new terminal screen is opened (or rather the current terminal is
    #   requested into either :raw or :cooked mode).
    # - The cursor visibility is then set dependent on this mode. In :raw mode,
    #   the cursor is hidden.
    # - The `:_initialize_` event is triggered. Vedeu does not handle this
    #   event; the client application may treat this event as Vedeu signalling
    #   that it is now ready.
    # - We enter into the main sequence where the application will either run
    #   once or continuous, interactively or standalone.
    #
    # @return []
    def start
      Terminal.open do
        Terminal.set_cursor_mode

        Vedeu.trigger(:_initialize_)

        runner { main_sequence }
      end
    end

    private

    # Runs the application loop either once, or forever (exceptions and signals
    # permitting).
    #
    # @return []
    def runner
      if Configuration.once?
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
      if Configuration.interactive?
        Input.capture

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
      loop { yield }

    rescue ModeSwitch
      Terminal.switch_mode!

      Application.restart

    end

  end # Application
  # :nocov:
end # Vedeu
