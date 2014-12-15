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
      @attributes = defaults.merge(attributes)
      @align      = @attributes[:align]
      @text       = @attributes[:text]
      @width      = @attributes[:width]
      @parent     = @attributes[:parent]

      if block_given?
        @self_before_instance_eval = eval('self', block.binding)

        instance_eval(&block)
      end
    end

    # Returns an array of characters, each element is the escape sequences of
    # colours and styles for this stream, the character itself, and the escape
    # sequences of colours and styles for the parent of the stream
    # ({Vedeu::Line}).
    #
    # @return [Array]
    def chars
      return [] if empty?

      char_attrs = view_attributes.merge!({ parent: parent })

      @_chars ||= content.chars.map do |c|
        Char.new(char_attrs.merge!({ value: c })).to_s
      end
    end

    # Returns the text aligned if a width was set, otherwise just the text. This
    # method also has the alias_method :data, a convenience method to provide
    # Presentation with a consistent interface.
    #
    # @return [String]
    def content
      width? ? aligned : text
    end
    alias_method :data, :content

    # Returns a boolean indicating whether the stream has content.
    #
    # @return [Boolean]
    def empty?
      size == 0
    end

    # Returns the size of the content in characters without formatting.
    #
    # @return [Fixnum]
    def size
      content.size
    end

    private

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

    # @param method [Symbol] The name of the method sought.
    # @param args [Array] The arguments which the method was to be invoked with.
    # @param block [Proc] The optional block provided to the method.
    # @return []
    def method_missing(method, *args, &block)
      Vedeu.log("Stream#method_missing '#{method}' (args: #{args.inspect})")

      @self_before_instance_eval.send(method, *args, &block) if @self_before_instance_eval
    end

  end # Stream

end # Vedeu
