require 'virtus'

require_relative '../support/cursor'
require_relative '../support/esc'

module Vedeu
  class Style
    include Virtus.model

    attribute :value, Array

    def initialize(values = [])
      super({ value: Array(values) })
    end

    # def to_compositor
    #   value
    # end

    def to_s
      value.map { |s| value_to_s(s) }.join
    end

    def empty?
      value.empty?
    end

    private

    attr_reader :values

    def value_to_s(value)
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
