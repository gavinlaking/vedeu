module Vedeu
  module Terminal
    extend self

    # @param block [Proc]
    # @return []
    def open(&block)
      fail InvalidSyntax, '`open` requires a block.' unless block_given?

      if raw_mode?
        console.raw    { initialize_screen { yield } }

      else
        console.cooked { initialize_screen { yield } }

      end
    ensure
      restore_screen

    end

    # @return [String]
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

    # @param stream [String]
    # @return [String]
    def output(stream = '')
      console.print(stream)

      stream
    end

    # @param block [Proc]
    # @return []
    def initialize_screen(&block)
      output Esc.string 'screen_init'

      yield
    end

    # @return [String]
    def clear_screen
      output Esc.string 'clear'
    end

    # @return [String]
    def restore_screen
      output Esc.string 'screen_exit'
      output clear_last_line
    end

    # @return [String]
    def set_cursor_mode
      output Esc.string 'show_cursor' unless raw_mode?
    end

    # @return [Boolean]
    def cooked_mode?
      mode == :cooked
    end

    # @return [Boolean]
    def raw_mode?
      mode == :raw
    end

    def switch_mode!
      if raw_mode?
        @_mode = :cooked

      else
        @_mode = :raw

      end
    end

    # @return [String]
    def clear_last_line
      Esc.set_position((height - 1), 1) + Esc.string('clear_line')
    end

    # @return [Fixnum]
    def colour_mode
      Configuration.colour_mode
    end

    # Returns the mode of the terminal, either `:raw` or `:cooked`
    #
    # @return [Symbol]
    def mode
      @_mode ||= Configuration.terminal_mode
    end

    # Returns a coordinate tuple of the format [y, x], where `y` is the row/line
    # and `x` is the column/character.
    #
    # @return [Array]
    def centre
      [(height / 2), (width / 2)]
    end

    # Returns the `y` (row/line) component of the coordinate tuple provided by
    # {Terminal.centre}
    #
    # @return [Fixnum]
    def centre_y
      centre.first
    end

    # Returns the `x` (column/character) component of the coodinate tuple
    # provided by {Terminal.centre}
    #
    # @return [Fixnum]
    def centre_x
      centre.last
    end

    # Returns the total width (number of columns/characters) of the current
    # terminal.
    #
    # @return [Fixnum]
    def width
      size.last
    end

    # Returns the total height (number of rows/lines) of the current terminal.
    #
    # @return [Fixnum]
    def height
      size.first
    end

    # Returns a tuple containing the height and width of the current terminal.
    #
    # @return [Array]
    def size
      console.winsize
    end

    # @return [File]
    def console
      IO.console
    end

  end
end
