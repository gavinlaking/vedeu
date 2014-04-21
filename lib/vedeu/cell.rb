module Vedeu
  class Cell
    # @param  data [Value]
    # @return [Vedeu::Cell]
    def initialize(data = nil)
      @data = data
    end

    # @return [Value]
    def first
      Array(data).first
    end
    alias_method :value, :first

    private

    attr_reader :data
  end
end
