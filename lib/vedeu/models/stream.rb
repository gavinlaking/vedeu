module Vedeu

  # A Stream can represent a character or collection of characters as part of a
  # {Vedeu::Line} which you wish to colour and style independently of the other
  # characters in that line.
  #
  # @api private
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

    # Returns the content of this stream.
    #
    # @return [String]
    def content
      data
    end

    private

    # Returns the text aligned if a width was set, otherwise just the text.
    #
    # @return [String]
    def data
      width? ? aligned : text
    end

    # Returns an aligned string if the string is shorter than the specified
    # width; the excess area being padded by spaces.
    #
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
    # @return [Boolean]
    def width?
      !!width
    end

    # The default values for a new instance of Stream.
    #
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

    # @return []
    def method_missing(method, *args, &block)
      Vedeu.log("Stream#method_missing '#{method.to_s}' (args: #{args.inspect})")

      @self_before_instance_eval.send(method, *args, &block)
    end

  end # Stream

end # Vedeu
