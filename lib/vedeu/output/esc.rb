module Vedeu
  module Esc
    extend self

    def blink
      [esc, '5m'].join
    end

    def bold
      [esc, '1m'].join
    end
    alias_method :bright, :bold

    def clear
      [esc, '2J'].join
    end

    def clear_line
      [esc, '2K'].join
    end

    def esc
      [27.chr, '['].join
    end

    def inverse
      [esc, '7m'].join
    end
    alias_method :reverse, :inverse

    def normal
      [esc, '2m'].join
    end
    alias_method :dim, :normal

    def reset
      [esc, '0m'].join
    end

    def underline
      [esc, '4m'].join
    end
  end
end
