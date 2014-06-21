module Vedeu
  class Layer
    attr_reader :index

    def initialize(index = 0)
      @index = index || 0
    end
  end
end
