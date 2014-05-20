module Vedeu
  class Style
    class << self
      def use(style)
        new(style).use
      end
    end

    def initialize(style)
      @style = style
    end

    def use
      case style
      when :bold        then Esc.bold
      when :clear       then Esc.clear
      when :hide_cursor then Esc.hide_cursor
      when :inverse     then Esc.inverse
      when :reset       then Esc.reset
      when :show_cursor then Esc.show_cursor
      when :underline   then Esc.underline
      else
        ""
      end
    end

    private

    attr_reader :style
  end
end
