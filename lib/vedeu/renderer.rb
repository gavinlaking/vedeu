module Vedeu
  class Renderer
    def initialize(row = []) # or buffer?
      @row = row
    end

    def render
      row.join
    end

    private

    attr_reader :row
  end
end
