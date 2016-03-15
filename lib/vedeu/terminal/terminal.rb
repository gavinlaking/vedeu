# frozen_string_literal: true

module Vedeu

  # This module is the direct interface between Vedeu and your
  # terminal/ console, via Ruby's IO core library.
  #
  # @api private
  #
  module Terminal

    include Vedeu::Terminal::Mode
    extend Forwardable
    extend self

    def_delegators Vedeu::Configuration,
                   :height,
                   :width

    alias tyn height
    alias txn width

    # Opens a terminal screen in either `raw` or `cooked` mode. On
    # exit, attempts to restore the screen. See
    # {Vedeu::Terminal#restore_screen}.
    #
    # @macro param_block
    # @macro raise_requires_block
    # @return [Array]
    def open(&block)
      raise Vedeu::Error::RequiresBlock unless block_given?

      if raw_mode? || fake_mode?
        console.raw    { initialize_screen(mode) { yield } }

      else
        console.cooked { initialize_screen(mode) { yield } }

      end
    ensure
      restore_screen
    end

    # Prints the streams to the screen and returns the streams.
    #
    # @param streams [String|Array]
    # @return [Array]
    def output(*streams)
      streams.each do |stream|
        Vedeu.log(type:    :output,
                  message: "Writing to terminal #{stream.size} bytes")

        console.print(stream)
      end
    end
    alias write output

    # {include:file:docs/dsl/by_method/resize.md}
    # @return [Boolean]
    def resize
      Vedeu.trigger(:_clear_)

      Vedeu.trigger(:_refresh_)

      true
    end

    # @macro param_block
    # @param mode [Symbol]
    # @return [void]
    def initialize_screen(mode, &block)
      Vedeu.log(message: "Terminal entering '#{mode}' mode")

      output(Vedeu.esc.screen_init)

      yield if block_given?
    end

    # Disables the mouse and shows the cursor.
    #
    # @return [String]
    def debugging!
      output(Vedeu.esc.mouse_x10_off + Vedeu.esc.show_cursor)
    end

    # Clears the entire terminal space.
    #
    # @example
    #   Vedeu.clear
    #
    # @return [String]
    def clear
      output(Vedeu.esc.clear)
    end

    # Attempts to tidy up the screen just before the application
    # terminates. The cursor is shown, colours are reset to terminal
    # defaults, the terminal is told to reset, and finally we clear
    # the last line ready for the prompt.
    #
    # @return [String]
    def restore_screen
      output(Vedeu.esc.screen_exit)
    end

    # Sets the cursor to be visible unless in raw mode, whereby it
    # will be left hidden.
    #
    # @return [String]
    def set_cursor_mode
      output(Vedeu.esc.show_cursor) unless raw_mode?
    end

    # Returns a coordinate tuple of the format [y, x], where `y` is
    # the row/line and `x` is the column/character.
    #
    # @return [Array]
    def centre
      [(height / 2), (width / 2)]
    end

    # Returns the `y` (row/line) component of the coordinate tuple
    # provided by {Vedeu::Terminal.centre}
    #
    # @return [Fixnum]
    def centre_y
      centre[0]
    end

    # Returns the `x` (column/character) component of the coodinate
    # tuple provided by {Vedeu::Terminal.centre}
    #
    # @return [Fixnum]
    def centre_x
      centre[-1]
    end

    # Returns 1. This 1 is either the top-most or left-most coordinate
    # of the terminal.
    #
    # @return [Fixnum]
    def origin
      1
    end
    alias tx origin
    alias ty origin

    # Returns a tuple containing the height and width of the current
    # terminal.
    #
    # @return [Array<Fixnum>]
    def size
      console.winsize
    end

    # Provides our gateway into the wonderful rainbow-filled world of
    # IO.
    #
    # @return [File]
    def console
      IO.console
    end

  end # Terminal

  # @api public
  # @!method resize
  #   @see Vedeu::Terminal#resize
  def_delegators Vedeu::Terminal,
                 :resize

end # Vedeu
