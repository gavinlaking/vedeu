require 'io/console'

require_relative 'esc'

module Vedeu
  module Terminal
    extend self
    # :nocov:
    def open(mode, &block)
      @mode = mode

      if block_given?
        if raw_mode?
          console.raw    { initialize_screen { yield } }

        else
          console.cooked { initialize_screen { yield } }

        end
      end
    ensure
      restore_screen
    end

    def input
      if raw_mode?
        keys = console.getch
        if keys.ord == 27
          keys << console.read_nonblock(3) rescue nil
          keys << console.read_nonblock(2) rescue nil
        end
        keys

      else
        console.gets.chomp

      end
    end
    # :nocov:

    def output(stream = '')
      console.print(stream)

      stream
    end

    # :nocov:
    def initialize_screen(&block)
      output Esc.string 'reset'
      output Esc.string 'clear'
      output Esc.string 'hide_cursor'

      yield
    end

    def restore_screen
      output Esc.string 'show_cursor'
      output Esc.string 'reset'
      output clear_last_line
    end

    def set_cursor_mode
      output Esc.string 'show_cursor' unless raw_mode?
    end

    def raw_mode?
      @mode == :raw
    end
    # :nocov:

    def clear_last_line
      Esc.set_position((height - 1), 1) + "\e[2K"
    end

    def centre
      [(height / 2), (width / 2)]
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
  end
end
