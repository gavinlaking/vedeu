module Vedeu
  class Application
    class << self

      # @return []
      def start
        new.start
      end
      alias_method :restart, :start

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

        Vedeu.events.trigger(:_initialize_)

        runner { main_sequence }
      end
    end

    private

    # @api private
    # @return []
    def runner
      if Configuration.once?
        yield

      else
        run_many { yield }

      end
    end

    # @api private
    # @return []
    def main_sequence
      if Configuration.interactive?
        Input.capture

      else
        # TODO: What should happen here?

      end
    end

    # @api private
    # @return []
    def run_many
      loop { yield }

    rescue ModeSwitch
      Terminal.switch_mode!

      Application.restart

    end

  end
end
