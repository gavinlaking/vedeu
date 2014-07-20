require 'io/console'

require_relative '../support/esc'

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
    # :nocov:

    def input
      if raw_mode?
        console.getc

      else
        console.gets.chomp

      end
    end

    def output(stream = '')
      console.print(stream)

      stream
    end

    def initialize_screen(&block)
      output Esc.string 'reset'
      output Esc.string 'clear'
      output Esc.string 'hide_cursor'

      yield
    end

    def restore_screen
      output Esc.string 'show_cursor'
      output Esc.string 'reset'
      output Esc.clear_last_line
    end

    def set_cursor_mode
      output Esc.string 'show_cursor' unless raw_mode?
    end

    def mode_switch
      if raw_mode?
        Application.start({ mode: :cooked })

      else
        Application.start({ mode: :raw })

      end
    end

    def raw_mode?
      @mode == :raw
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
