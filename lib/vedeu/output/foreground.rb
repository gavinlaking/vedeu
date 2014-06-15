module Vedeu
  class Foreground < Base
    private

    def prefix
      named? ? '38;2;' : '38;5;'
    end

    def codes
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
  end
end
