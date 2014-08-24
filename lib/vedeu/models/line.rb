module Vedeu
  class Line

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
    def streams
      @streams ||= Attributes.coercer(attributes[:streams], Stream, :text)
    end

    # @return []
    def style
      @style ||= Attributes.coerce_styles(attributes[:style])
    end

    # @return []
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
