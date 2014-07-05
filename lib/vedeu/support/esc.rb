require_relative 'translator'

module Vedeu
  module Esc
    extend self

    def background_colour(value = '#000000')
      [esc, '48;5;', colour_translator(value), 'm'].join
    end

    def blink
      [esc, '5m'].join
    end

    def blink_off
      [esc, '25m'].join
    end

    def bold
      [esc, '1m'].join
    end

    def bold_off
      [esc, '21m'].join
    end

    def clear
      [esc, '2J'].join
    end

    def clear_line
      [esc, '2K'].join
    end

    def esc
      [27.chr, '['].join
    end

    def foreground_colour(value = '#ffffff')
      [esc, '38;5;', colour_translator(value), 'm'].join
    end
#
    def negative
      [esc, '7m'].join
    end

    def positive
      [esc, '27m'].join
    end

    def normal
      [underline_off, bold_off, positive].join
    end

    def dim
      [esc, '2m'].join
    end

    def reset
      [esc, '0m'].join
    end

    def underline
      [esc, '4m'].join
    end

    def underline_off
      [esc, '24m'].join
    end

    private

    def colour_translator(value)
      Translator.translate(value)
    end
  end
end
