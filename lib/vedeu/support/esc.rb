module Vedeu
  module Esc
    extend self

    def set_position(y = 1, x = 1)
      row    = (y == 0 || y == nil) ? 1 : y
      column = (x == 0 || x == nil) ? 1 : x

      ["\e[", row, ';', column, 'H'].join
    end

    def string(value = '')
      case value
      when 'bg_reset'      then "\e[48;2;49m"
      when 'blink'         then "\e[5m"
      when 'blink_off'     then "\e[25m"
      when 'bold'          then "\e[1m"
      when 'bold_off'      then "\e[21m"
      when 'clear'         then "\e[38;2;39m\e[48;2;49m\e[2J"
      when 'clear_line'    then "\e[38;2;39m\e[48;2;49m\e[2K"
      when 'colour_reset'  then "\e[38;2;39m\e[48;2;49m"
      when 'fg_reset'      then "\e[38;2;39m"
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
  end
end
