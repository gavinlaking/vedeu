module Vedeu
  class Esc
    class << self
      # @return [String]
      def clear
        [esc, '2J'].join
      end

      # @return [String]
      def hide_cursor
        [esc, '?25l'].join
      end

      # @return [String]
      def show_cursor
        [esc, '?25h'].join
      end

      # @return [String]
      def inverse
        [esc, '7m'].join
      end

      # @return [String]
      def reset
        [esc, '0m'].join
      end

      # @return [String]
      def set(fg, bg)
        new(fg, bg).set
      end

      # @return [String]
      def esc
        [27.chr, '['].join
      end
    end

    # @param  fg [Integer]
    # @param  bg [Integer]
    # @return    [Vedeu::Esc]
    def initialize(fg, bg)
      @fg, @bg = fg, bg
    end

    # @return [String]
    def set
      [Esc.esc, fg, ';', bg, 'm'].join
    end

    private

    attr_reader :fg, :bg
  end
end
