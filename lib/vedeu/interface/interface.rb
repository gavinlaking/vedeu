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
      raise NotImplementedError, 'Subclasses implement this method.'
    end

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
end
