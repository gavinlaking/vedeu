module Vedeu
  class ColourTranslator

    # @param colour [String]
    # @return [String]
    def self.escape_sequence(colour = '')
      new(colour).escape_sequence
    end

    # @param colour [String]
    # @return [ColourTranslator]
    def initialize(colour = '')
      @colour = colour
    end

    # @return [String]
    def escape_sequence
      if no_colour?
        ''

      elsif named?
        named

      elsif numbered?
        numbered

      elsif rgb?
        rgb

      else
        ''

      end
    end

    private

    attr_reader :colour

    def no_colour?
      colour.nil? || colour.to_s.empty?
    end

    def named?
      colour.is_a?(Symbol) && valid_name?
    end

    def named
      fail NotImplemented, 'Subclasses implement this.'
    end

    def valid_name?
      codes.keys.include?(colour)
    end

    def numbered?
      colour.is_a?(Fixnum) && valid_range?
    end

    def numbered
      fail NotImplemented, 'Subclasses implement this.'
    end

    def valid_range?
      colour >= 0 && colour <= 255
    end

    def rgb?
      colour.is_a?(String) && valid_rgb?
    end

    def rgb
      fail NotImplemented, 'Subclasses implement this.'
    end

    def valid_rgb?
      colour =~ /^#([A-Fa-f0-9]{6})$/
    end

    def css_to_rgb
      [
        colour[1..2].to_i(16),
        colour[3..4].to_i(16),
        colour[5..6].to_i(16)
      ]
    end

    def css_to_numbered
      if rgb?
        [16, red, green, blue].inject(:+)

      elsif numbered?
        colour

      end
    end

    def red
      (css_to_rgb[0] / 51) * 36
    end

    def green
      (css_to_rgb[1] / 51) * 6
    end

    def blue
      (css_to_rgb[2] / 51) * 1
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
