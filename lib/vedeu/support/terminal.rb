require 'io/console'

require_relative '../support/esc'

module Vedeu
  module Terminal
    extend self
    # :nocov:
    def open(mode = :raw, &block)
      @mode = mode

      if raw_mode?
        raw_mode(block)

      else
        cooked_mode(block)

      end
    ensure
      restore_screen
    end
    # :nocov:

    def input
      if raw_mode?
        console.gets.chomp

      else
        console.gets.chomp

      end
    end

    def output(stream = '')
      console.print(stream)

      stream
    end

    def cooked_mode(&block)
      console.cooked do
        initialize_screen

        yield
      end if block_given?
    end

    def raw_mode(&block)
      console.raw do
        initialize_screen

        yield
      end if block_given?
    end

    def initialize_screen
      output Esc.string('reset')
      output Esc.string('clear')
      output Esc.string('hide_cursor')
    end

    def restore_screen
      output Esc.string('show_cursor')
      output Esc.string('reset')
      output Esc.clear_last_line
    end

    def raw_mode?
      @mode == :raw
    end

    def cooked_mode?
      @mode == :cooked
    end

    def toggle_mode
      if raw_mode?
        @mode = :cooked
      else
        @mode = :raw
      end
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
