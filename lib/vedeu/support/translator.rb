module Vedeu
  class Translator
    def self.translate(html_colour = '')
      new(html_colour).translate
    end

    def initialize(html_colour = '')
      @html_colour = html_colour
    end

    def translate
      return '' unless valid?

      [16, red, green, blue].inject(:+)
    end

    private

    attr_reader :html_colour

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
