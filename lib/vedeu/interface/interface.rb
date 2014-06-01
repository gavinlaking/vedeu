module Vedeu
  class NotImplementedError < StandardError; end

  class Interface
    def initialize(options = {})
      @options = options
      @output  = []
    end

    def initial_state
      raise NotImplementedError, 'Subclasses implement this method.'
    end

    def input
      raise Collapse if evaluate == :stop
    end

    def output
      write
    end

    def geometry
      @geometry ||= Geometry.new(options[:geometry])
    end

    private

    attr_reader :options

    def evaluate
      @output = Commands.execute(read)
    end

    def read
      Terminal.input
    end

    def write
      Compositor.arrange(@output, self)
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
