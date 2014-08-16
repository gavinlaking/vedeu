module Vedeu
  class ColourTranslator
    def initialize(html_colour = '', options = {})
      @html_colour = html_colour
      @options     = options
    end

    def background
      return '' unless valid?

      if truecolor?
        r, g, b = translate
        ["\e[48;2;", r, ';', g, ';', b, 'm'].join

      else
        ["\e[48;5;", translate, 'm'].join

      end
    end

    def foreground
      return '' unless valid?

      if truecolor?
        r, g, b = translate
        ["\e[38;2;", r, ';', g, ';', b, 'm'].join

      else
        ["\e[38;5;", translate, 'm'].join

      end
    end

    private

    attr_reader :html_colour

    def translate
      if truecolor?
        [red, green, blue]
      else
        [
          16,
          ((red / 51) * 36),
          ((green / 51) * 6),
          ((blue / 51) * 1)
        ].inject(:+)
      end
    end

    def red
      html_colour[1..2].to_i(16)
    end

    def green
      html_colour[3..4].to_i(16)
    end

    def blue
      html_colour[5..6].to_i(16)
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

    def truecolor?
      options.fetch(:truecolor)
    end

    def options
      defaults.merge!(@options)
    end

    def defaults
      {
        truecolor: false
      }
    end
  end
end
