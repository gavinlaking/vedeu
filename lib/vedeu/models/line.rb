module Vedeu
  class Line
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

    def streams
      @streams ||= Attributes.coercer(attributes[:streams], Stream, :text)
    end

    def style
      @style ||= Attributes.coerce_styles(attributes[:style])
    end

    def to_s
      [ colour, style, streams ].join
    end

    private

    def defaults
      {
        colour:  {},
        streams: [],
        style:   []
      }
    end

    def method_missing(method, *args, &block)
      @self_before_instance_eval.send(method, *args, &block)
    end
  end
end
