module Vedeu
  class Terminal
    class << self
      def input
        console.getc
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

      def cooked(&block)
        console.cooked do
          clear_screen

          yield
        end if block_given?
      end
      alias_method :open_cooked, :cooked
      alias_method :open,        :cooked

      def raw(&block)
        console.raw &block if block_given?
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
    end
  end
end
