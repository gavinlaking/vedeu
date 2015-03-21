require 'vedeu/output/presentation'
require 'vedeu/models/all'

module Vedeu

  # A Stream can represent a character or collection of characters as part of a
  # {Vedeu::Line} which you wish to colour and style independently of the other
  # characters in that line.
  #
  class Stream

    include Vedeu::Model
    include Vedeu::Presentation

    collection Vedeu::Chars
    member     Vedeu::Char

    # @!attribute [rw] parent
    # @return [Line]
    attr_accessor :parent

    # @!attribute [rw] value
    # @return [String]
    attr_accessor :value

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
    # @return [Vedeu::Stream]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)
      @colour     = @attributes[:colour]
      @parent     = @attributes[:parent]
      @style      = @attributes[:style]
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
        member.new({ value:    char,
                     parent:   parent,
                     colour:   colour,
                     style:    style,
                     position: nil })
      end
    end

    # Returns a boolean indicating whether the stream has content.
    #
    # @return [Boolean]
    def empty?
      value.empty?
    end

    # Returns the size of the content in characters without formatting.
    #
    # @return [Fixnum]
    def size
      value.size
    end

    def to_char(li, si)
      cs = chars.each_with_index do |c, i|
        c.position = IndexPosition[li, i, parent.parent.top, parent.parent.left]
        c
      end
      cs.flatten
    end

    # @return [String]
    def value
      # Vedeu::Char.coerce(@value, parent, colour, style)
      # @value ||= if @value.size > 1
      #   @value.chars.map do |char|
      #     Vedeu::Char.new(char, parent, colour, style)
      #   end
      # elsif @value.size == 1
      #   Vedeu::Char.new(@value, parent, colour, style)
      # else
      #   # ???
      # end

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
