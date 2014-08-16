module Vedeu
  class Stream
    def self.build(attributes = {}, &block)
      new(attributes, &block).attributes
    end

    def initialize(attributes = {}, &block)
      @attributes = attributes

      if block_given?
        @self_before_instance_eval = eval('self', block.binding)

        instance_eval(&block)
      end
    end

    def attributes
      @_attributes ||= defaults.merge!(@attributes)
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
        style:  [],
        text:   '',
        width:  nil,
        align:  :left
      }
    end

    def method_missing(method, *args, &block)
      @self_before_instance_eval.send(method, *args, &block)
    end
  end
end
