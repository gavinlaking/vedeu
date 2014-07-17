require 'io/console'

require_relative '../support/esc'

module Vedeu
  module Terminal
    extend self
    # :nocov:
    def open(&block)
      console.cooked do
        output Esc.string('reset')
        output Esc.string('clear')
        output Esc.string('hide_cursor')

        yield
      end if block_given?
    ensure
      output Esc.string('show_cursor')
      output Esc.string('reset')
      output Esc.clear_last_line
    end
    # :nocov:

    def input
      console.gets.chomp
    end

    def output(stream = '')
      console.print(stream)

      stream
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
