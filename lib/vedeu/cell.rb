module Vedeu
  class Cell
    def initialize(data = nil)
      @data = data
    end

    def first
      Array(data).first
    end

    alias_method :value, :first

    private

    attr_reader :data
  end
end
