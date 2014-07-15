require_relative 'terminal'
require_relative 'translator'

module Vedeu
  module Esc
    extend self

    def background_colour(value = '#000000')
      ["\e[48;5;", colour_translator(value), 'm'].join
    end

    def clear_line
      "\e[2K"
    end

    def clear_last_line
      set_position((Terminal.height - 1), 1) + clear_line
    end

    def foreground_colour(value = '#ffffff')
      ["\e[38;5;", colour_translator(value), 'm'].join
    end

    def set_position(y = 1, x = 1)
      row    = (y == 0 || y == nil) ? 1 : y
      column = (x == 0 || x == nil) ? 1 : x

      ["\e[", row, ';', column, 'H'].join
    end

    def string(value = '')
      case value
      when 'blink'         then "\e[5m"
      when 'blink_off'     then "\e[25m"
      when 'bold'          then "\e[1m"
      when 'bold_off'      then "\e[21m"
      when 'clear'         then "\e[2J"
      when 'colour_reset'  then "\e[38;2;39m\e[48;2;49m"
      when 'hide_cursor'   then "\e[?25l"
      when 'negative'      then "\e[7m"
      when 'positive'      then "\e[27m"
      when 'reset'         then "\e[0m"
      when 'normal'        then "\e[24m\e[21m\e[27m"
      when 'dim'           then "\e[2m"
      when 'show_cursor'   then "\e[?25h"
      when 'underline'     then "\e[4m"
      when 'underline_off' then "\e[24m"
      else
        ''
      end
    end

    private

    def colour_translator(value)
      Translator.translate(value)
    end
  end
end
