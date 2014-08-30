module Vedeu
  class Line
    include Coercions
    include Presentation

    attr_reader :attributes

    # @param attributes [Hash]
    # @param block [Proc]
    # @return [Hash]
    def self.build(attributes = {}, &block)
      new(attributes, &block).attributes
    end

    # @param attributes [Hash]
    # @param block [Proc]
    # @return [Line]
    def initialize(attributes = {}, &block)
      @attributes = defaults.merge!(attributes)

      if block_given?
        @self_before_instance_eval = eval('self', block.binding)

        instance_eval(&block)
      end
    end

    # @return [Array]
    def streams
      @streams ||= Stream.coercer(attributes[:streams])
    end

    # @return [String]
    def to_s
      [ colour, style, streams ].join
    end

    private

    # @api private
    # @return [Hash]
    def defaults
      {
        colour:  {},
        streams: [],
        style:   []
      }
    end

    # @api private
    # @return []
    def method_missing(method, *args, &block)
      @self_before_instance_eval.send(method, *args, &block)
    end

  end
end
