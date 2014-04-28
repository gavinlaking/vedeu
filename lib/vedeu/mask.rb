module Vedeu
  class Mask
    class << self
      def [](fg, bg)
        new(fg, bg).mask
      end
    end

    def initialize(fg, bg)
      @fg, @bg = fg, bg
    end

    def mask
      [fg, bg]
    end

    private

    attr_reader :fg, :bg
  end
end
