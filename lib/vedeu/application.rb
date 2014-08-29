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

    # @return []
    def start
      Terminal.open do
        Terminal.set_cursor_mode

        Vedeu.events.trigger(:_initialize_)

        runner { main_sequence }
      end
    end

    private

    # @return []
    def runner
      if Configuration.once?
        yield

      else
        run_many { yield }

      end
    end

    # @return []
    def main_sequence
      if Configuration.interactive?
        Input.capture

      else
        # TODO: What should happen here?

      end
    end

    # @return []
    def run_many
      loop { yield }

    rescue ModeSwitch
      Terminal.switch_mode!

      Application.restart

    end

  end
end
