module Vedeu
  class Application
    class << self
      def start(interfaces = nil, options = {}, &block)
        new(interfaces, options).start(&block)
      end
    end

    def initialize(interfaces = nil, options = {})
      @interfaces, @options = interfaces, options
    end

    def start(&block)
      if block_given?

      else
        Terminal.open(options) do
          initial_state

          Process.event_loop
        end
      end
    ensure
      puts
      Terminal.show_cursor
      Terminal.clear_screen
    end

    private

    attr_reader :options

    def initial_state
      interfaces.initial
    end

    def interfaces
      @interfaces ||= Interfaces.default
    end

    def options
      defaults.merge!(@options)
    end

    def defaults
      {
        mode:    :cooked, # or :raw
      }
    end
  end
end
