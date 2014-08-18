module Vedeu
  class ColourTranslator
    def initialize(html_colour = '')
      @html_colour = html_colour
    end

    def background
      return '' unless valid?

      sprintf("\e[48;2;%s;%s;%sm", *translate)
    end

    def foreground
      return '' unless valid?

      sprintf("\e[38;2;%s;%s;%sm", *translate)
    end

    private

    attr_reader :html_colour

    def translate
      [
        html_colour[1..2].to_i(16),
        html_colour[3..4].to_i(16),
        html_colour[5..6].to_i(16)
      ]
    end

    def valid?
      html_colour.is_a?(String) && html_colour =~ /^#([A-Fa-f0-9]{6})$/
    end
  end
end
