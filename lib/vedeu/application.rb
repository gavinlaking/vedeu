module Vedeu
  class Application
    def self.start(interfaces, options = {}, &block)
      new(interfaces, options).main(&block)
    end

    def initialize(interfaces, options = {})
      @interfaces, @options = interfaces, options
    end

    def main
      Terminal.open do
        Clock.start do
          real_work
        end
      end
    rescue OutOfTimeError
      # puts 'Done.'
    ensure
      Terminal.show_cursor
    end

    def real_work
      interfaces.run
      sleep 0.1
    end

    def simulated_work
      sleep 0.1
    end

    private

    def interfaces
      @interfaces ||= Vedeu::Interfaces.default
    end

    attr_reader :options
  end
end
