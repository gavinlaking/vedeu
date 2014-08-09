module Vedeu
  class ColourTranslator
    def self.translate(html_colour = '')
      new(html_colour).value
    end

    def initialize(html_colour = '')
      @html_colour = html_colour
    end

    def background
      return '' unless valid?

      ["\e[48;5;", translate, 'm'].join
    end

    def foreground
      return '' unless valid?

      ["\e[38;5;", translate, 'm'].join
    end

    def value
      return '' unless valid?

      translate
    end

    private

    attr_reader :html_colour

    def translate
      [16, red, green, blue].inject(:+)
    end

    def red
      (html_colour[1..2].to_i(16) / 51) * 36
    end

    def green
      (html_colour[3..4].to_i(16) / 51) * 6
    end

    def blue
      (html_colour[5..6].to_i(16) / 51) * 1
    end

    def valid?
      present? && valid_type? && valid_format?
    end

    def present?
      return true unless html_colour.nil? || html_colour.empty?

      false
    end

    def valid_type?
      html_colour.is_a?(String)
    end

    def valid_format?
      html_colour =~ /^#([A-Fa-f0-9]{6})$/
    end
  end
end
