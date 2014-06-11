module Vedeu
  class Style
    class << self
      def set(style)
        new(style).set
      end
    end

    def initialize(style)
      @style = style
    end

    def set
      case style
      when :bold        then Esc.bold
      when :clear       then Esc.clear
      when :hide_cursor then Esc.hide_cursor
      when :inverse     then Esc.inverse
      when :reset       then Esc.reset
      when :normal      then Esc.reset
      when :show_cursor then Esc.show_cursor
      when :underline   then Esc.underline
      else
        ''
      end
    end

    private

    attr_reader :style
  end
end
