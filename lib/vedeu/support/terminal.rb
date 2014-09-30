module Vedeu

  # This module is the direct interface between Vedeu and your terminal/
  # console, via Ruby's IO core library.
  #
  # @api private
  module Terminal

    extend self

    # Opens a terminal screen in either `raw` or `cooked` mode. On exit,
    # attempts to restore the screen. See {Vedeu::Terminal#restore_screen}.
    #
    # @param block [Proc]
    # @return [Array]
    def open(&block)
      fail InvalidSyntax, '`open` requires a block.' unless block_given?

      if raw_mode?
        Vedeu.log("Terminal entering 'raw' mode")

        console.raw    { initialize_screen { yield } }

      else
        Vedeu.log("Terminal entering 'cooked' mode")

        console.cooked { initialize_screen { yield } }

      end
    ensure
      restore_screen

    end

    # Takes input from the user via the keyboard. Accepts special keys like
    # the F-Keys etc, by capturing the entire sequence.
    #
    # @return [String]
    # :nocov:
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

    # Prints the streams to the screen and returns the streams.
    #
    # @param streams [String|Array]
    # @return [Array]
    def output(*streams)
      streams.each { |stream| console.print(stream) }

      streams
    end

    # @param block [Proc]
    # @return []
    def initialize_screen(&block)
      output Esc.string 'screen_init'

      yield
    end

    # Clears the entire terminal space.
    #
    # @return [String]
    def clear_screen
      output Esc.string 'clear'
    end

    # Attempts to tidy up the screen just before the application terminates.
    # The cursor is shown, colours are reset to terminal defaults, the
    # terminal is told to reset, and finally we clear the last line ready for
    # the prompt.
    #
    # @return [String]
    def restore_screen
      output(Esc.string('screen_exit'), Esc.string('clear_last_line'))
    end

    # Sets the cursor to be visible unless in raw mode, whereby it will be left
    # hidden.
    #
    # @return [String]
    def set_cursor_mode
      output Esc.string 'show_cursor' unless raw_mode?
    end

    # Returns a boolean indicating whether the terminal is currently in `cooked`
    # mode.
    #
    # @return [Boolean]
    def cooked_mode?
      mode == :cooked
    end

    # Sets the terminal in to `cooked` mode.
    #
    # @return [Symbol]
    def cooked_mode!
      @_mode = :cooked
    end

    # Returns a boolean indicating whether the terminal is currently in `raw`
    # mode.
    #
    # @return [Boolean]
    def raw_mode?
      mode == :raw
    end

    # Sets the terminal in to `raw` mode.
    #
    # @return [Symbol]
    def raw_mode!
      @_mode = :raw
    end

    # Toggles the terminal's mode between `cooked` and `raw`, depending on its
    # current mode.
    #
    # @return [Symbol]
    def switch_mode!
      if raw_mode?
        Vedeu.log("Terminal switching to 'cooked' mode")

        cooked_mode!

      else
        Vedeu.log("Terminal switching to 'raw' mode")

        raw_mode!

      end
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
    # {Vedeu::Terminal.centre}
    #
    # @return [Fixnum]
    def centre_y
      centre.first
    end

    # Returns the `x` (column/character) component of the coodinate tuple
    # provided by {Vedeu::Terminal.centre}
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

    # Provides our gateway into the wonderful rainbow-filled world of IO.
    #
    # @return [File]
    def console
      IO.console
    end

  end # Terminal

end # Vedeu
