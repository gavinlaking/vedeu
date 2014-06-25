module Vedeu
  class Colour
    class << self
      def set(pair = [])
        return '' if pair.empty?

        new(pair).set
      end

      def reset
        new.reset
      end
    end

    def initialize(pair = [])
      @pair = pair || []
    end

    def set
      [foreground, background].join
    end

    def reset
      [foreground(:default), background(:default)].join
    end

    def foreground(value = pair[0])
      @foreground ||= Foreground.escape_sequence(value)
    end

    def background(value = pair[1])
      @background ||= Background.escape_sequence(value)
    end

    private

    attr_reader :pair
  end
end
