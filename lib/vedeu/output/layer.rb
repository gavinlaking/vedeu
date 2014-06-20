module Vedeu
  class Layer
    def initialize(values = {})
      @values = values || {}
    end

    def index
      values[:layer]
    end

    private

    def values
      defaults.merge!(@values)
    end

    def defaults
      {
        layer: 0
      }
    end
  end
end
