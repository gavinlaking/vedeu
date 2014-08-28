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

    # @return []
    def runner
      if interactive?
        interactive { yield }

      else
        run_once    { yield }

      end
    end

    # @return []
    def main_sequence
      Input.capture
    end

    # @return [TrueClass|FalseClass]
    def interactive?
      options.fetch(:interactive)
    end

    # @return []
    def interactive
      loop { yield }

    rescue ModeSwitch
      if Terminal.raw_mode?
        Application.start({ mode: :cooked })

      else
        Application.start({ mode: :raw })

      end
    end

    # @return []
    def run_once
      yield
    end

    # @return [Symbol]
    def mode
      options.fetch(:mode)
    end

    # @return []
    def debug
      Vedeu::API::Trace.call if options.fetch(:debug)
    end

    # @return [Hash]
    def options
      defaults.merge!(@options)
    end

    # @return [Hash]
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
