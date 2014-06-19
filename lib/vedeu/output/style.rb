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
      when :blink       then Esc.blink
      when :blink_off   then Esc.blink_off
      when :bold        then Esc.bold
      when :bold_off    then Esc.bold_off
      when :clear       then Esc.clear
      when :hide_cursor then Cursor.hide
      when :inverse     then Esc.inverse
      when :negative    then Esc.negative
      when :positive    then Esc.positive
      when :reset       then Esc.reset
      when :normal      then Esc.reset
      when :show_cursor then Cursor.show
      when :underline   then Esc.underline
      when :underline_off then Esc.underline_off
      else
        ''
      end
    end

    private

    attr_reader :style
  end
end
