module Vedeu
  class Application
    def self.start(interfaces, options = {}, &block)
      new(interfaces, options).start(&block)
    end

    def initialize(interfaces, options = {})
      @interfaces, @options = interfaces, options
    end

    def start(&block)
      Terminal.open do

        initial_state

        Clock.start do
          keys = Input::Keyboard.capture

          # yield if block_given?

          sleep 0.1
        end
      end
    rescue OutOfTimeError
      # puts 'Done.'
    ensure
      Terminal.show_cursor
    end

    private

    def initial_state
      interfaces.initial
    end

    def interfaces
      @interfaces ||= Screen.default
    end

    attr_reader :options
  end
end
