module Vedeu
  module Input
    class Wrapper
      class << self
        def enable_arrow_keys
          Curses.stdscr.keypad(true)
        end

        def disable_arrow_keys
          Curses.stdscr.keypad(false)
        end

        def keypress
          Curses.getch
        end
        alias_method :get_character, :keypress
        alias_method :getch,         :keypress

        def press_up
          Curses::Key::UP
        end

        def press_down
          Curses::Key::DOWN
        end

        def press_left
          Curses::Key::LEFT
        end

        def press_right
          Curses::Key::RIGHT
        end

        def press_end
          Curses::KEY_END
        end

        def press_home
          Curses::KEY_HOME
        end

        def press_page_down
          Curses::KEY_NPAGE
        end

        def press_page_up
          Curses::KEY_PPAGE
        end

        def press_insert
          Curses::KEY_IC
        end

        def press_fkeys
          Curses::KEY_F0..Curses::KEY_F63
        end

        def press_f0
          Curses::KEY_F0
        end

        def press_delete
          Curses::KEY_DC
        end

        def press_resize
          Curses::KEY_RESIZE
        end
      end
    end
  end
end
