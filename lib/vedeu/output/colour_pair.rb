module Vedeu
  class ColourPair
    class << self
      def define(pair = [])
        return '' if pair.empty?

        new(pair).define
      end
      alias_method :set, :define

      def reset
        new.reset
      end
    end

    def initialize(pair = [])
      @pair = pair || []
    end

    def define
      [foreground, background].join
    end
    alias_method :set, :define

    def reset
      [foreground(:default), background(:default)].join
    end

    def foreground(value = pair[0])
      @foreground ||= Foreground.escape_sequence(value)
    end
    alias_method :fg, :foreground

    def background(value = pair[1])
      @background ||= Background.escape_sequence(value)
    end
    alias_method :bg, :background

    private

    attr_reader :pair
  end
end
