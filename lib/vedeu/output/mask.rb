module Vedeu
  class Mask
    class << self
      def define(mask = [])
        new(mask).define
      end
      alias_method :set, :define
    end

    def initialize(mask = [])
      @mask = mask
    end

    def define
      [foreground, background].join
    end

    private

    attr_reader :mask

    def foreground
      Foreground.escape_sequence(mask[0])
    end

    def background
      Background.escape_sequence(mask[1])
    end
  end
end
