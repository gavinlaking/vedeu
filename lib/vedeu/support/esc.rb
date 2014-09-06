module Vedeu

  # Provides escape sequence strings for setting the cursor position and various
  # display related functions.
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

    # Return the escape sequence string from the list of recognised sequence
    # 'commands', or an empty string if the 'command' cannot be found.
    #
    # @param value [String|Symbol]
    # @return [String]
    def string(value = '')
      return '' if value.to_sym.empty?

      sequences.fetch(value.to_sym, proc { '' }).call
    end

    private

    # @api private
    # @return [Hash]
    def sequences
      {
        bg_reset:        proc { bg_reset },
        blink:           proc { blink },
        blink_off:       proc { blink_off },
        bold:            proc { bold },
        bold_off:        proc { bold_off },
        clear:           proc { clear },
        clear_line:      proc { clear_line },
        clear_last_line: proc { clear_last_line },
        colour_reset:    proc { colour_reset },
        dim:             proc { dim },
        fg_reset:        proc { fg_reset },
        hide_cursor:     proc { hide_cursor },
        negative:        proc { negative },
        normal:          proc { normal },
        positive:        proc { positive },
        reset:           proc { reset },
        screen_init:     proc { screen_init },
        screen_exit:     proc { screen_exit },
        show_cursor:     proc { show_cursor },
        underline:       proc { underline },
        underline_off:   proc { underline_off },
      }
    end

    # @api private
    # @return [String]
    def bg_reset
      "\e[48;2;49m"
    end

    # @api private
    # @return [String]
    def blink
      "\e[5m"
    end

    # @api private
    # @return [String]
    def blink_off
      "\e[25m"
    end

    # @api private
    # @return [String]
    def bold
      "\e[1m"
    end

    # @api private
    # @return [String]
    def bold_off
      "\e[22m"
    end

    # @api private
    # @return [String]
    def clear
      [ string('fg_reset'),
        string('bg_reset'),
        "\e[2J" ].join
    end

    # @api private
    # @return [String]
    def clear_line
      [ string('fg_reset'),
        string('bg_reset'),
        "\e[2K" ].join
    end

    # @api private
    # @return [String]
    def clear_last_line
      [ set_position((Terminal.height - 1), 1),
        string('clear_line') ].join
    end

    # @api private
    # @return [String]
    def colour_reset
      [ string('fg_reset'),
        string('bg_reset') ].join
    end

    # @api private
    # @return [String]
    def dim
      "\e[2m"
    end

    # @api private
    # @return [String]
    def fg_reset
      "\e[38;2;39m"
    end

    # @api private
    # @return [String]
    def hide_cursor
      "\e[?25l"
    end

    # @api private
    # @return [String]
    def negative
      "\e[7m"
    end

    # @api private
    # @return [String]
    def normal
      [ string('underline_off'),
        string('bold_off'),
        string('positive') ].join
    end

    # @api private
    # @return [String]
    def positive
      "\e[27m"
    end

    # @api private
    # @return [String]
    def reset
      "\e[0m"
    end

    # @api private
    # @return [String]
    def screen_init
      [ string('reset'),
        string('clear'),
        string('hide_cursor') ].join
    end

    # @api private
    # @return [String]
    def screen_exit
      [ string('show_cursor'),
        string('colour_reset'),
        string('reset') ].join
    end

    # @api private
    # @return [String]
    def show_cursor
      "\e[?25h"
    end

    # @api private
    # @return [String]
    def underline
      "\e[4m"
    end

    # @api private
    # @return [String]
    def underline_off
      "\e[24m"
    end

  end
end
