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

    def left(count = 1)
      [Esc.esc, "#{count || 1}", 'D'].join
    end

    def save
      [Esc.esc, 's'].join
    end

    def restore
      [Esc.esc, 'u'].join
    end

    def save_all
      [Esc.esc, '7'].join
    end

    def restore_all
      [Esc.esc, '8'].join
    end
  end
end
