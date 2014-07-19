require_relative 'input/input'
require_relative 'output/output'
require_relative 'process/process'
require_relative 'support/terminal'

module Vedeu
  class Application
    # :nocov:
    def self.start(options = {})
      new(options).start
    end

    def initialize(options = {})
      @options = options || {}
    end

    def start
      Terminal.open do
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
    rescue StopIteration
    end

    def run_once
      yield
    end

    def options
      defaults.merge!(@options)
    end

    def defaults
      {
        interactive: true
      }
    end
    # :nocov:
  end
end
