module Vedeu
  module Terminal
    extend self

    # @param []
    # @param []
    # @return []
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

    # @return []
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

    # @param []
    # @return []
    def output(stream = '')
      console.print(stream)

      stream
    end

    # @param []
    # @return []
    def initialize_screen(&block)
      output Esc.string 'screen_init'

      yield
    end

    # @return []
    def clear_screen
      output Esc.string 'clear'
    end

    # @return []
    def restore_screen
      output Esc.string 'screen_exit'
      output clear_last_line
    end

    # @return []
    def set_cursor_mode
      output Esc.string 'show_cursor' unless raw_mode?
    end

    # @return []
    def raw_mode?
      @mode == :raw
    end

    # @return []
    def clear_last_line
      Esc.set_position((height - 1), 1) + Esc.string('clear_line')
    end

    # @return []
    def colour_mode
      Configuration.options[:colour_mode]
    end

    # @return []
    def centre
      [(height / 2), (width / 2)]
    end

    # @return [Fixnum] The total width of the current terminal.
    def width
      size.last
    end

    # @return [Fixnum] The total height of the current terminal.
    def height
      size.first
    end

    # @return []
    def size
      console.winsize
    end

    # @return []
    def console
      IO.console
    end
  end
end
