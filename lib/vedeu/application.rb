module Vedeu
  class Application

    # :nocov:
    # @param options [Hash]
    # @return []
    def self.start(options = {})
      new(options).start
    end

    # @param options [Hash]
    # @return [Application]
    def initialize(options = {})
      @options = options
    end

    # @return []
    def start
      Terminal.open(mode) do
        Terminal.set_cursor_mode

        Vedeu.events.trigger(:_initialize_)

        runner { main_sequence }
      end
    end

    private

    attr_reader :options

    def runner
      if interactive?
        interactive { yield }

      else
        run_once    { yield }

      end
    end

    def main_sequence
      Input.capture
    end

    def interactive?
      options.fetch(:interactive)
    end

    def interactive
      loop { yield }

    rescue ModeSwitch
      if Terminal.raw_mode?
        Application.start({ mode: :cooked })

      else
        Application.start({ mode: :raw })

      end
    end

    def run_once
      yield
    end

    def mode
      options.fetch(:mode)
    end

    def debug
      Vedeu::API::Trace.call if options.fetch(:debug)
    end

    def options
      defaults.merge!(@options)
    end

    def defaults
      {
        debug:       false,
        interactive: true,
        mode:        :raw
      }
    end
    # :nocov:

  end
end
