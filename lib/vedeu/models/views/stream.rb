module Vedeu

  module Views

    # Represents a character or collection of characters as part of a
    # {Vedeu::Views::Line} which you wish to colour and style independently of
    # the other characters in that line.
    #
    class Stream

      include Vedeu::Model
      include Vedeu::Presentation

      collection Vedeu::Views::Chars
      member     Vedeu::Views::Char

      # @!attribute [rw] parent
      # @return [Vedeu::Views::Line]
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

      # Returns a new instance of Vedeu::Views::Stream.
      #
      # @param attributes [Hash]
      # @option attributes value [String]
      # @option attributes parent [Vedeu::Views::Line]
      # @option attributes colour [Vedeu::Colour]
      # @option attributes style [Vedeu::Style]
      # @return [Vedeu::Views::Stream]
      def initialize(attributes = {})
        @attributes = defaults.merge!(attributes)

        @attributes.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # @param child [Vedeu::Views::Stream]
      # @return [Vedeu::Views::Streams]
      def add(child)
        parent.add(child)
      end
      alias_method :<<, :add

      # Returns an array of characters, each element is the escape sequences of
      # colours and styles for this stream, the character itself, and the escape
      # sequences of colours and styles for the parent of the stream
      # ({Vedeu::Views::Line}).
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

      # An object is equal when its values are the same.
      #
      # @param other [Vedeu::Views::Char]
      # @return [Boolean]
      def eql?(other)
        self.class == other.class && value == other.value &&
          colour == other.colour && style == other.style &&
          parent == other.parent
      end
      alias_method :==, :eql?

      # Returns the size of the content in characters without formatting.
      #
      # @return [Fixnum]
      def size
        value.size
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

  end # Views

end # Vedeu
