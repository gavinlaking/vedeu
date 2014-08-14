module Vedeu
  class Stream
    def initialize(_attributes = {})
      @_attributes = _attributes
    end

    def attributes
      _attributes
    end

    def colour
      @colour ||= Colour.new(_attributes[:colour])
    end

    def style
      @style ||= Attributes.coerce_styles(_attributes[:style])
    end

    def text
      @text ||= _attributes[:text]
    end

    def width
      @width ||= _attributes[:width]
    end

    def align
      @align ||= _attributes[:align]
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

    def _attributes
      defaults.merge!(@_attributes)
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
