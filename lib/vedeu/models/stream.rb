module Vedeu
  class Stream
    include Coercions
    include Presentation

    attr_reader :attributes, :align, :text, :width

    # @param attributes [Hash]
    # @param block [Proc]
    # @return [Hash]
    def self.build(attributes = {}, &block)
      new(attributes, &block).attributes
    end

    # @param attributes [Hash]
    # @param block [Proc]
    # @return [Stream]
    def initialize(attributes = {}, &block)
      @attributes = defaults.merge!(attributes)
      @align      = @attributes[:align]
      @text       = @attributes[:text]
      @width      = @attributes[:width]

      if block_given?
        @self_before_instance_eval = eval('self', block.binding)

        instance_eval(&block)
      end
    end

    # @return [String]
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
