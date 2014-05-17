module Vedeu
  class Terminal
    class << self
      def input
        # console.getc  # => cooked
        # console.getch # => raw
        console.gets    # => stream
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

      def open(options = {}, &block)
        new(options).open(&block)
      end

      def cooked(&block)
        console.cooked do
          clear_screen

          yield
        end if block_given?
      end
      alias_method :open_cooked, :cooked

      def raw(&block)
        console.raw do
          clear_screen

          yield
        end if block_given?
      end
      alias_method :open_raw, :raw

      def console
        IO.console
      end

      def clear_screen
        print Esc.clear
      end

      def show_cursor
        print Esc.show_cursor
      end

      def hide_cursor
        print Esc.hide_cursor
      end

      def set_position(y = 0, x = 0)
        print Esc.set_position(y, x)
      end
      alias_method :origin, :set_position
    end

    def initialize(options = {}, &block)
      @options = options

      yield self if block_given?
    end

    def open(&block)
      terminal_mode(&block).fetch(mode, noop).call
    end

    private

    def terminal_mode(&block)
      {
        cooked: Proc.new { Terminal.cooked(&block) },
        raw:    Proc.new { Terminal.raw(&block) }
      }
    end

    def mode
      options.fetch(:mode, :cooked)
    end

    def noop
      Proc.new {}
    end

    def options
      defaults.merge!(@options)
    end

    def defaults
      {
        mode: :cooked # or :raw
      }
    end
  end
end
