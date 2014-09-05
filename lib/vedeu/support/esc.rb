module Vedeu

  # TODO: what does this module do?
  module Esc

    extend self

    # Return the escape sequence required to position the cursor at a particular
    # point on the screen. When passed a block, will do the aforementioned,
    # call the block and then reposition to this location.
    #
    # @param y     [Fixnum] The row/line position.
    # @param x     [Fixnum] The column/character position.
    # @param block [Proc]
    # @return      [String]
    def set_position(y = 1, x = 1, &block)
      Position.new(y, x).to_s(&block)
    end

    # @param value [String]
    # @return [String]
    def string(value = '')
      case value
      when 'bg_reset'      then "\e[48;2;49m"
      when 'blink'         then "\e[5m"
      when 'blink_off'     then "\e[25m"
      when 'bold'          then "\e[1m"
      when 'bold_off'      then "\e[22m"
      when 'clear'         then "\e[38;2;39m\e[48;2;49m\e[2J"
      when 'clear_line'    then "\e[38;2;39m\e[48;2;49m\e[2K"
      when 'clear_last_line' then
        [ set_position((Terminal.height - 1), 1),
          string('clear_line') ].join

      when 'colour_reset'  then
        [ string('fg_reset'),
          string('bg_reset') ].join

      when 'dim'           then "\e[2m"
      when 'fg_reset'      then "\e[38;2;39m"
      when 'hide_cursor'   then "\e[?25l"
      when 'negative'      then "\e[7m"
      when 'normal'        then
        [ string('underline_off'),
          string('bold_off'),
          string('positive') ].join

      when 'positive'      then "\e[27m"
      when 'reset'         then "\e[0m"
      when 'screen_init'   then
        [ string('reset'),
          string('clear'),
          string('hide_cursor') ].join

      when 'screen_exit'   then
        [ string('show_cursor'),
          string('colour_reset'),
          string('reset') ].join
      when 'show_cursor'   then "\e[?25h"
      when 'underline'     then "\e[4m"
      when 'underline_off' then "\e[24m"
      else
        ''
      end
    end

    # private

    # def method_missing(method, *args, &block)
    #   self.send(:string, method, &block)
    # end

  end
end
