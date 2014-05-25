module Vedeu
  class NotImplementedError < StandardError; end

  class Interface
    def initialize(options = {})
      @options = options
    end

    def initial_state
      raise NotImplementedError, 'Subclasses implement this method.'
    end

    def event_loop
      while true do
        command = input

        break if command == :stop

        output(command)
      end
    end

    def input
      evaluate
    end

    def output(command)
      Compositor.arrange(command, self)
    end

    def geometry
      @geometry ||= Geometry.new(options[:geometry])
    end

    private

    attr_reader :options

    def evaluate
      Commands.execute(read)
    end

    def read
      Terminal.input
    end

    def options
      defaults.merge!(@options)
    end

    def defaults
      {
        geometry: {
                    y:      1,
                    x:      1,
                    width:  :auto,
                    height: :auto
                  }
      }
    end
  end
end
