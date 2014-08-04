require 'virtus'

require 'vedeu/models/colour'
require 'vedeu/models/style'

module Vedeu
  class Stream
    include Virtus.model

    attribute :colour, Colour,  default: Colour.new
    attribute :style,  Style,   default: ''
    attribute :text,   String,  default: ''
    attribute :width,  Integer
    attribute :align,  Symbol,  default: :left # :centre, :right

    def to_s(options = {})
      if width
        aligned = case align
        when :left   then text.ljust(width,  ' ')
        when :right  then text.rjust(width,  ' ')
        when :centre then text.center(width, ' ')
        end

        [colour, style, aligned].join
      else
        [colour, style, text].join
      end
    end
  end
end
