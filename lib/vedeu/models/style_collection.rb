require 'virtus'

require_relative '../support/cursor'
require_relative '../support/esc'
require_relative 'coercions'

module Vedeu
  class StyleCollection < Virtus::Attribute
    include Coercions

    def coerce(values)
      return '' if empty?(values)

      if multiple?(values)
        values.map { |value| stylize(value) }.join
      elsif just_text?(values)
        stylize(values)
      end
    end

    def stylize(value)
      case value
      when 'blink'         then Esc.blink
      when 'blink_off'     then Esc.blink_off
      when 'bold'          then Esc.bold
      when 'bold_off'      then Esc.bold_off
      when 'clear'         then Esc.clear
      when 'hide_cursor'   then Cursor.hide
      when 'negative'      then Esc.negative
      when 'positive'      then Esc.positive
      when 'reset'         then Esc.reset
      when 'normal'        then Esc.normal
      when 'dim'           then Esc.dim
      when 'show_cursor'   then Cursor.show
      when 'underline'     then Esc.underline
      when 'underline_off' then Esc.underline_off
      else
        ''
      end
    end
  end
end
