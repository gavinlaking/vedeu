module Vedeu
  class Colour
    class << self
      # @param  pair [Array]
      # @return      [String]
      def set(pair = [])
        new(pair).set
      end
      alias_method :reset, :set

      # @param  pair [Array]
      # @return      [String]
      def reset(pair = [])
        new(pair).reset
      end
    end

    # @param  pair [Array]
    # @return      [Vedeu::Colour]
    def initialize(pair = [])
      @pair = pair
    end

    # @return [String]
    def set
      return reset if pair.empty?

      Esc.set(foreground_code, background_code)
    end

    # @return [String]
    def reset
      Esc.reset
    end

    private

    attr_reader :pair

    def foreground_code
      foreground_codes[foreground] || foreground_codes[:default]
    end

    def background_code
      background_codes[background] || background_codes[:default]
    end

    def foreground_codes
      {
        black:   30,
        red:     31,
        green:   32,
        yellow:  33,
        blue:    34,
        magenta: 35,
        cyan:    36,
        white:   37,
        default: 39,
      }
    end

    def background_codes
      {
        black:   40,
        red:     41,
        green:   42,
        yellow:  43,
        blue:    44,
        magenta: 45,
        cyan:    46,
        white:   47,
        default: 49,
      }
    end

    def foreground
      pair[0]
    end

    def background
      pair[1]
    end
  end
end
