module Vedeu
  class Stream

    # @param []
    # @param []
    # @return []
    def self.build(attributes = {}, &block)
      new(attributes, &block).attributes
    end

    # @param []
    # @param []
    # @return []
    def initialize(attributes = {}, &block)
      @attributes = attributes

      if block_given?
        @self_before_instance_eval = eval('self', block.binding)

        instance_eval(&block)
      end
    end

    # @return []
    def attributes
      @_attributes ||= defaults.merge!(@attributes)
    end

    # @return []
    def colour
      @colour ||= Colour.new(attributes[:colour])
    end

    # @return []
    def style
      @style ||= Attributes.coerce_styles(attributes[:style])
    end

    # @return []
    def text
      @text ||= attributes[:text]
    end

    # @return []
    def width
      @width ||= attributes[:width]
    end

    # @return []
    def align
      @align ||= attributes[:align]
    end

    # @return []
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
