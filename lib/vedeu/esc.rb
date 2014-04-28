module Vedeu
  class Esc
    class << self
      def bold
        [esc, '1m'].join
      end

      def clear
        [esc, '2J'].join
      end

      def esc
        [27.chr, '['].join
      end

      def hide_cursor
        [esc, '?25l'].join
      end

      def inverse
        [esc, '7m'].join
      end

      def reset
        [esc, '0m'].join
      end

      def set(fg, bg)
        new(fg, bg).set
      end

      def show_cursor
        [esc, '?25h'].join
      end

      def underline
        [esc, '4m'].join
      end
    end

    def initialize(fg, bg)
      @fg, @bg = fg, bg
    end

    def set
      [Esc.esc, fg, ';', bg, 'm'].join
    end

    private

    attr_reader :fg, :bg
  end
end
