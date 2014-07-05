require 'io/console'

require_relative '../support/cursor'
require_relative '../support/esc'

module Vedeu
  module Terminal
    extend self
    # :nocov:
    def open(&block)
      console.cooked do
        output Esc.reset
        output Esc.clear
        output Cursor.hide

        yield
      end if block_given?
    ensure
      output Cursor.show
      output Esc.reset
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
