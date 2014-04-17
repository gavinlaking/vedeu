module Vedeu
  class Colour
    class << self
      # @param  pair [Array]
      # @return      [String]
      def set(pair = [])
        new(pair).set
      end
      alias_method :reset, :set
    end

    # @param  pair [Array]
    # @return      [Vedeu::Colour]
    def initialize(pair = [])
      @pair = pair
    end

    # @return [String]
    def set
      return reset if pair.empty?

      [esc, foreground_code, ';', background_code, 'm'].join
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

    def reset
      [esc, '0m'].join
    end

    def esc
      [27.chr, '['].join
    end
  end

  def self.test_Vedue__Colour(klass = Vedeu::Colour)
    codes = [
              :black,
              :red,
              :green,
              :yellow,
              :blue,
              :magenta,
              :cyan,
              :white,
              :default
            ]

    codes.each do |fg|
      codes.each do |bg|
        print [klass.set([fg, bg]), '*', klass.reset].join
      end
      puts
    end
    puts
  end
end
