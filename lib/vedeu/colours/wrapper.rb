module Vedeu
  module Colours
    class Wrapper
      class << self

        def normal
          Curses::A_NORMAL
        end

        def reverse
          Curses::A_REVERSE
        end
        alias_method :inverse, :reverse

        def black
          Curses::COLOR_BLACK
        end

        def blue
          Curses::COLOR_BLUE
        end

        def cyan
          Curses::COLOR_CYAN
        end

        def green
          Curses::COLOR_GREEN
        end

        def magenta
          Curses::COLOR_MAGENTA
        end

        def red
          Curses::COLOR_RED
        end

        def white
          Curses::COLOR_WHITE
        end

        def yellow
          Curses::COLOR_YELLOW
        end

      # colour

        def enable_colours
          Curses.start_colour if terminal_supports_colours?
        end

        def terminal_supports_colours?
          Curses.has_colors?
        end

      # screen

        def columns
          Curses.stdscr.maxx
        end
        alias_method :width, :columns

        def lines
          Curses.stdscr.maxy
        end
        alias_method :height, :lines

        def delay
          Curses.stdscr.nodelay = 1
        end
        alias_method :enable_timeouts, :delay

        def no_delay
          Curses.stdscr.nodelay = 0
        end
        alias_method :disable_timeouts, :no_delay

        def set_position(y = 0, x = 0)
          Curses.setpos(y, x)
        end

        def add_string(string)
          Curses.addstr(string)
        end

        def hide_typed_characters
          Curses.noecho
        end

        def show_typed_characters
          Curses.echo
        end

        def new_line_translation_off
          Curses.nonl
        end

        def new_line_translation_on
          Curses.nl
        end

        def enable_raw_mode
          Curses.raw
        end

        def disable_raw_mode
          Curses.no_raw
        end

        def open_screen
          Curses.init_screen
        end

        def close_screen
          Curses.close_screen
        end

        def clear_screen
          Curses.clear
        end

      # style

        def define_pair(id, foreground, background)
          Curses.init_pair(id, foreground, background)
        end

        def colour_pair(pair_id)
          Curses.color_pair(pair_id)
        end

        def set_style(style)
          Curses.attrset(style)
        end

      end
    end
  end
end
