module Vedeu
  module Cursor
    extend self

    def show
      [Esc.esc, '?25h'].join
    end

    def hide
      [Esc.esc, '?25l'].join
    end

    def home
      [Esc.esc, 'H'].join
    end

    def up(count = 1)
      [Esc.esc, "#{count || 1}", 'A'].join
    end

    def down(count = 1)
      [Esc.esc, "#{count || 1}", 'B'].join
    end

    def right(count = 1)
      [Esc.esc, "#{count || 1}", 'C'].join
    end
    alias_method :forward, :right

    def left(count = 1)
      [Esc.esc, "#{count || 1}", 'D'].join
    end
    alias_method :backward, :left

    def save
      [Esc.esc, 's'].join
    end

    def unsave
      [Esc.esc, 'u'].join
    end
    alias_method :restore, :unsave

    def save_all
      [Esc.esc, '7'].join
    end

    def unsave_all
      [Esc.esc, '8'].join
    end
    alias_method :restore_all, :unsave_all
  end
end
