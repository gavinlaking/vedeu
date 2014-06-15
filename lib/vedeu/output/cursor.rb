module Vedeu
  class Cursor
    class << self
      def show
        [esc, '?25h'].join
      end

      def hide
        [esc, '?25l'].join
      end

      def home
        [esc, 'H'].join
      end

      def up(count = 1)
        [esc, "#{count || 1}", 'A'].join
      end

      def down(count = 1)
        [esc, "#{count || 1}", 'B'].join
      end

      def right(count = 1)
        [esc, "#{count || 1}", 'C'].join
      end
      alias_method :forward, :right

      def left(count = 1)
        [esc, "#{count || 1}", 'D'].join
      end
      alias_method :backward, :left

      def save
        [esc, 's'].join
      end

      def unsave
        [esc, 'u'].join
      end
      alias_method :restore, :unsave

      def save_all
        [esc, '7'].join
      end

      def unsave_all
        [esc, '8'].join
      end
      alias_method :restore_all, :unsave_all

      def esc
        [27.chr, '['].join
      end
    end
  end
end
