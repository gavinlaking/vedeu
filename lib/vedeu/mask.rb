module Vedeu
  class Mask
    class << self
      # @param  fg [Symbol]
      # @param  bg [Symbol]
      # @return [Array]
      def [](fg, bg)
        new(fg, bg).mask
      end
    end

    # @param  fg [Symbol]
    # @param  bg [Symbol]
    # @return [Vedeu::Mask]
    def initialize(fg, bg)
      @fg, @bg = fg, bg
    end

    # @return [Array]
    def mask
      [fg, bg]
    end

    private

    attr_reader :fg, :bg
  end
end
