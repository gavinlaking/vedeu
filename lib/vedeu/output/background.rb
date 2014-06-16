module Vedeu
  class Background < Base
    private

    def custom
      '48;5;'
    end

    def normal
      '48;2;'
    end

    def codes
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
  end
end
