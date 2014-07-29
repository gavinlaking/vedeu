require 'vedeu/support/esc'

module Vedeu
  module Helpers
    def foreground(value)
      Esc.foreground_colour(value)
    end
    alias_method :fg, :foreground

    def background(value)
      Esc.background_colour(value)
    end
    alias_method :bg, :background

    def style(*value_or_values)
      if value_or_values.one?
        Esc.string(value_or_values.first)
      else
        value_or_values.map { |s| Esc.string(s) }.join
      end
    end
  end
end
