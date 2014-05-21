module Vedeu
  class Interface
    def initialize(options = {})
      @options = options
    end

    def initial_state; end

    def event_loop; end

    private

    attr_reader :options

    def width
      options[:width]
    end

    def height
      options[:height]
    end

    def options
      defaults.merge!(@options)
    end

    def defaults
      {
        width:  Terminal.width,
        height: Terminal.height
      }
    end
  end

  class Dummy < Interface; end
end
