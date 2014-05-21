module Vedeu
  class Terminal
    class << self
      def input
        console.gets.chomp
      end

      def output(stream = '')
        console.puts(stream)
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

      def close
        clear_screen
        show_cursor
        output(Position.reset)
      end

      def cooked(instance, &block)
        console.cooked do
          instance.initial_setup!

          yield
        end if block_given?
      end
      alias_method :open_cooked, :cooked

      def raw(instance, &block)
        console.raw do
          instance.initial_setup!

          yield
        end if block_given?
      end
      alias_method :open_raw, :raw

      def console
        IO.console
      end

      def clear_screen
        output(Esc.reset)
        output(Esc.clear)
      end

      def clear_line(index)
        output(Position.set(index, 0))
        output(" " * width)
      end

      def show_cursor
        output(Esc.show_cursor)
      end

      def hide_cursor
        output(Esc.hide_cursor)
      end
    end

    def initialize(options = {}, &block)
      @options = options

      yield self if block_given?
    end

    def open(&block)
      terminal_mode(&block).fetch(mode, noop).call
    end

    def initial_setup!
      Terminal.clear_screen if clear_screen?
      set_cursor
      Terminal.output(Position.reset)
    end

    private

    def terminal_mode(&block)
      {
        cooked: Proc.new { Terminal.cooked(self, &block) },
        raw:    Proc.new { Terminal.raw(self, &block) }
      }
    end

    def cursor_mode
      {
        show: Proc.new { Terminal.show_cursor },
        hide: Proc.new { Terminal.hide_cursor }
      }
    end

    def set_cursor
      cursor_mode.fetch(cursor).call
    end

    def cursor
      options.fetch(:cursor, :show)
    end

    def mode
      options.fetch(:mode, :cooked)
    end

    def clear_screen?
      options.fetch(:clear, true)
    end

    def noop
      Proc.new {}
    end

    def options
      defaults.merge!(@options)
    end

    def defaults
      {
        mode:   :cooked, # or :raw
        clear:  true,    # or false (clears the screen if true)
        cursor: :show,   # or :hide
      }
    end
  end
end
