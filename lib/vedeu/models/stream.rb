module Vedeu
  class Stream
    def initialize(attributes = {})
      @attributes = attributes
    end

    def attributes
      defaults.merge!(@attributes)
    end

    def colour
      @colour ||= Colour.new(attributes[:colour])
    end

    def style
      @style ||= Attributes.coerce_styles(attributes[:style])
    end

    def text
      @text ||= attributes[:text]
    end

    def width
      @width ||= attributes[:width]
    end

    def align
      @align ||= attributes[:align]
    end

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

    def defaults
      {
        colour: {},
        style:  '',
        text:   '',
        width:  nil,
        align:  :left
      }
    end
  end
end
