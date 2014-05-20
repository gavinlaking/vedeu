module Vedeu
  class Colour
    class << self
      def define(pair = [])
        new(pair).define
      end
      alias_method :set, :define
    end

    def initialize(pair = [])
      @pair = pair
    end

    def define
      [foreground, background].join
    end

    private

    attr_reader :pair

    def foreground
      Foreground.escape_sequence(pair[0])
    end

    def background
      Background.escape_sequence(pair[1])
    end
  end
end
