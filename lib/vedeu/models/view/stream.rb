require 'vedeu/presentation/presentation'
require 'vedeu/models/view/char'

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

    attr_accessor :parent,
      :value

    alias_method :content, :value
    alias_method :data,    :value
    alias_method :text,    :value

    # Returns a new instance of Stream.
    #
    # @param attributes [Hash]
    # @option attributes value [String]
    # @option attributes parent [Vedeu::Line]
    # @option attributes colour [Vedeu::Colour]
    # @option attributes style [Vedeu::Style]
    # @option attributes client [Object]
    # @return [Vedeu::Stream]
    def initialize(attributes = {})
      @attributes = defaults.merge(attributes)
      @colour     = Colour.coerce(@attributes[:colour])
      @parent     = @attributes[:parent]
      @style      = Style.coerce(@attributes[:style])
      @value      = @attributes[:value]
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
      return [] if value.empty?

      value.chars.map do |char|
        member.new(char, parent, colour, style, nil).to_s
      end
    end

    # Returns a boolean indicating whether the stream has content.
    #
    # @return [Boolean]
    def empty?
      value.empty?
    end

    # Returns log friendly output.
    #
    # @return [String]
    def inspect
      "<#{self.class.name} (value:#{value}, size:#{size})>"
    end

    # Returns the size of the content in characters without formatting.
    #
    # @return [Fixnum]
    def size
      value.size
    end

    # @return [String]
    def value
      # Vedeu::Char.coerce(@value, parent, colour, style)
      @value
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
