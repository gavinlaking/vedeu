module Vedeu
  class Renderer
    # @param  row [Array]
    # @return     [Vedeu::Renderer]
    def initialize(row = []) # or buffer?
      @row = row
    end

    # @return [String]
    def render
      row.join
    end

    private

    attr_reader :row
  end
end
