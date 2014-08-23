module Vedeu
  module Esc
    extend self

    def set_position(y = 1, x = 1, &block)
      Position.new(y, x).to_s(&block)
    end

    def string(value = '')
      case value
      when 'bg_reset'      then "\e[48;2;49m"
      when 'blink'         then "\e[5m"
      when 'blink_off'     then "\e[25m"
      when 'bold'          then "\e[1m"
      when 'bold_off'      then "\e[22m"
      when 'clear'         then "\e[38;2;39m\e[48;2;49m\e[2J"
      when 'clear_line'    then "\e[38;2;39m\e[48;2;49m\e[2K"
      when 'colour_reset'  then "\e[38;2;39m\e[48;2;49m"
      when 'fg_reset'      then "\e[38;2;39m"
      when 'hide_cursor'   then "\e[?25l"
      when 'screen_init'   then "\e[0m\e[38;2;39m\e[48;2;49m\e[2J\e[?25l"
      when 'screen_exit'   then "\e[?25h\e[38;2;39m\e[48;2;49m\e[0m"
      when 'negative'      then "\e[7m"
      when 'positive'      then "\e[27m"
      when 'reset'         then "\e[0m"
      when 'normal'        then "\e[24m\e[22m\e[27m"
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
