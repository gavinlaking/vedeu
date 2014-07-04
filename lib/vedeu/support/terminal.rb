require 'io/console'

require_relative '../support/cursor'
require_relative '../support/esc'
require_relative '../support/position'

module Vedeu
  module Terminal
    extend self
    # :nocov:
    def open(&block)
      console.cooked do
        reset
        clear_screen
        hide_cursor

        yield
      end if block_given?
    ensure
      show_cursor
      reset
      clear_last_line
    end
    # :nocov:

    def input
      console.gets.chomp
    end

    def output(stream = '')
      console.print(stream)

      stream
    end

    def width
      size.last
    end

    def height
      size.first
    end

    def size
      console.winsize
    end

    def console
      IO.console
    end

    private

    def show_cursor
      output(Cursor.show)
    end

    def hide_cursor
      output(Cursor.hide)
    end

    def reset
      output(Esc.reset)
    end

    def clear_screen
      output(Esc.clear)
    end

    def clear_last_line
      output([
        Position.set((height - 1), 1),
        Esc.clear_line
      ].join)
    end
  end
end
