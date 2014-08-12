module Vedeu
  class Stream
    include Virtus.model

    attribute :colour, Colour,  default: Colour.new
    attribute :style,  Style,   default: ''
    attribute :text,   String,  default: ''
    attribute :width,  Integer
    attribute :align,  Symbol,  default: :left

    def to_s
      [ colour, style, data ].join
    end

    private

    def data
      width? ? aligned : text
    end

    def aligned
      case align
      when :right  then text.rjust(width,  ' ')
      when :centre then text.center(width, ' ')
      else text.ljust(width, ' ')
      end
    end

    def width?
      !!width
    end
  end
end
