module Vedeu
  class Colour
    class << self
      # @param  mask [Mask]
      # @return      [String]
      def set(mask = [])
        new(mask).set
      end
      alias_method :reset, :set

      # @param  mask [Array]
      # @return      [String]
      def reset(mask = [])
        new(mask).reset
      end
    end

    # @param  mask [Array]
    # @return      [Vedeu::Colour]
    def initialize(mask = [])
      @mask = mask
    end

    # @return [String]
    def set
      return reset if mask.empty?

      Esc.set(foreground_code, background_code)
    end

    # @return [String]
    def reset
      Esc.reset
    end

    private

    attr_reader :mask

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
      mask[0]
    end

    def background
      mask[1]
    end
  end
end
