module Vedeu

  # A Stream can represent a character or collection of characters as part of a
  # {Vedeu::Line} which you wish to colour and style independently of the other
  # characters in that line.
  class Stream

    include Coercions
    include Presentation

    attr_reader :attributes, :align, :text, :width, :parent

    # Builds up a new Stream object and returns the attributes.
    #
    # @param attributes [Hash]
    # @param block [Proc]
    # @return [Hash]
    def self.build(attributes = {}, &block)
      new(attributes, &block).attributes
    end

    # Returns a new instance of Stream.
    #
    # @param attributes [Hash]
    # @param block [Proc]
    # @return [Stream]
    def initialize(attributes = {}, &block)
      @attributes = defaults.merge!(attributes)
      @align      = @attributes[:align]
      @text       = @attributes[:text]
      @width      = @attributes[:width]
      @parent     = @attributes[:parent]

      if block_given?
        @self_before_instance_eval = eval('self', block.binding)

        instance_eval(&block)
      end
    end

    private

    # Returns the text aligned if a width was set, otherwise just the text.
    #
    # @api private
    # @return [String]
    def data
      width? ? aligned : text
    end

    # Returns an aligned string if the string is shorter than the specified
    # width; the excess area being padded by spaces.
    #
    # @api private
    # @return [String]
    def aligned
      case align
      when :right  then text.rjust(width,  ' ')
      when :centre then text.center(width, ' ')
      else text.ljust(width, ' ')
      end
    end

    # Returns a boolean to indicate whether this stream has a width set.
    #
    # @api private
    # @return [Boolean]
    def width?
      !!width
    end

    # The default values for a new instance of Stream.
    #
    # @api private
    # @return [Hash]
    def defaults
      {
        colour: {},
        style:  [],
        text:   '',
        width:  nil,
        align:  :left,
        parent: nil,
      }
    end

    # @api private
    # @return []
    def method_missing(method, *args, &block)
      @self_before_instance_eval.send(method, *args, &block)
    end

  end
end
