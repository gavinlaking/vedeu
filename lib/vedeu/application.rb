module Vedeu

  # Orchestrates the running of the main application loop.
  #
  # @api public
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
      # - A StopIteration exception is raised which will cause {#start} to exit
      #   its looop and terminate the application.
      #
      # @api private
      # @return [Exception]
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
    # @api private
    # @return []
    def runner
      if Configuration.once?
        yield

      else
        run_many { yield }

      end
    end

    # For an interactive application we capture input, (usually from the user),
    # and continue the main loop.
    #
    # @todo It appears for non-interactive applications, we do nothing. Must
    #   investigate.
    #
    # @api private
    # @return []
    def main_sequence
      if Configuration.interactive?
        Input.capture

      else


      end
    end

    # Runs the application in a continuous loop. This loop is stopped elsewhere
    # with the raising of the StopIteration exception.
    #
    # @api private
    # @return []
    def run_many
      loop { yield }

    rescue ModeSwitch
      Terminal.switch_mode!

      Application.restart

    end

  end
  # :nocov:
end
