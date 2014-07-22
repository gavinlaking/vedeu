require_relative 'input/input'
require_relative 'output/output'
require_relative 'process/process'
require_relative 'support/terminal'

module Vedeu
  ModeSwitch = Class.new(StandardError)

  class Application
    # :nocov:
    def self.start(options = {})
      new(options).start
    end

    def initialize(options = {})
      @options = options
    end

    def start
      Terminal.open(mode) do
        Terminal.set_cursor_mode

        Output.render

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

      Process.evaluate

      Output.render
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

    def options
      defaults.merge!(@options)
    end

    def defaults
      {
        interactive: true,
        mode:        :raw
      }
    end
    # :nocov:
  end
end
