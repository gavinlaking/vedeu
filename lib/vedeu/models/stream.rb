module Vedeu

  # A Stream can represent a character or collection of characters as part of a
  # {Vedeu::Line} which you wish to colour and style independently of the other
  # characters in that line.
  #
  # @api private
  class Stream

    include Vedeu::Model
    include Vedeu::Presentation

    collection Vedeu::Chars
    member     Vedeu::Char

    # @!attribute [rw] parent
    # @return [Vedeu::Line]
    attr_accessor :parent

    # @!attribute [rw] value
    # @return [String]
    attr_accessor :value
    alias_method :content, :value
    alias_method :data,    :value
    alias_method :text,    :value

    # @!attribute [r] attributes
    # @return [Hash]
    attr_reader :attributes

    # Returns a new instance of Vedeu::Stream.
    #
    # @param attributes [Hash]
    # @option attributes value [String]
    # @option attributes parent [Vedeu::Line]
    # @option attributes colour [Vedeu::Colour]
    # @option attributes style [Vedeu::Style]
    # @return [Vedeu::Stream]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)

      @attributes.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    # @param child [Vedeu::Stream]
    # @return [Vedeu::Streams]
    def add(child)
      parent.add(child)
    end

    # Returns an array of characters, each element is the escape sequences of
    # colours and styles for this stream, the character itself, and the escape
    # sequences of colours and styles for the parent of the stream
    # ({Vedeu::Line}).
    #
    # @return [Array]
    def chars
      return [] if empty?

      @chars ||= value.chars.map do |char|
        member.new(value:    char,
                   parent:   parent,
                   colour:   colour,
                   style:    style,
                   position: nil)
      end
    end

    # Returns a boolean indicating whether the stream has content.
    #
    # @return [Boolean]
    def empty?
      value.empty?
    end

    # An object is equal when its values are the same.
    #
    # @param other [Vedeu::Char]
    # @return [Boolean]
    def eql?(other)
      self.class == other.class && value == other.value &&
        colour == other.colour && style == other.style && parent == other.parent
    end
    alias_method :==, :eql?

    # @return [NilClass|String]
    def name
      parent.name if parent
    end

    # Returns the size of the content in characters without formatting.
    #
    # @return [Fixnum]
    def size
      value.size
    end

    # Delegate to Vedeu::Line#width if available.
    #
    # @return [Fixnum]
    def width
      parent.width if parent
    end

    private

    # The default values for a new instance of this class.
    #
    # @return [Hash]
    def defaults
      {
        client: nil,
        colour: nil,
        parent: nil,
        style:  nil,
        value:  '',
      }
    end

  end # Stream

end # Vedeu
