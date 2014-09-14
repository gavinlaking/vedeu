module Vedeu

  # A Line represents a single row of the terminal. It is a container for
  # {Vedeu::Stream} objects. A line's width is determined by the
  # {Vedeu::Interface} it belongs to.
  class Line

    include Coercions
    include Presentation

    attr_reader :attributes, :parent

    # Builds up a new Line object and returns the attributes.
    #
    # @param attributes [Hash]
    # @param block [Proc]
    # @return [Hash]
    def self.build(attributes = {}, &block)
      new(attributes, &block).attributes
    end

    # Returns a new instance of Line.
    #
    # @param attributes [Hash]
    # @param block [Proc]
    # @return [Line]
    def initialize(attributes = {}, &block)
      @attributes = defaults.merge!(attributes)
      @parent     = @attributes[:parent]

      if block_given?
        @self_before_instance_eval = eval('self', block.binding)

        instance_eval(&block)
      end
    end

    # Returns a collection of streams associated with this line.
    #
    # @return [Array]
    def streams
      @streams ||= Stream.coercer(attributes[:streams])
    end

    private

    # Convenience method to provide Presentation with a consistent interface.
    #
    # @api private
    # @return [Array]
    def data
      streams
    end

    # The default values for a new instance of Line.
    #
    # @api private
    # @return [Hash]
    def defaults
      {
        colour:  {},
        streams: [],
        style:   [],
        parent:  nil,
      }
    end

    # @api private
    # @return []
    def method_missing(method, *args, &block)
      @self_before_instance_eval.send(method, *args, &block)
    end

  end
end
