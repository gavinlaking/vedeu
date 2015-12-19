require 'vedeu/dsl/all'

module Vedeu

  module Views

    # Represents a character or collection of characters as part of a
    # {Vedeu::Views::Line} which you wish to colour and style
    # independently of the other characters in that line.
    #
    class Stream

      class DSL

        include Vedeu::DSL
        include Vedeu::DSL::Elements

      end # DSL

      include Vedeu::Views::DefaultAttributes
      include Vedeu::Repositories::Model
      include Vedeu::Repositories::Parent
      include Vedeu::Presentation

      include Vedeu::Views::Value
      collection Vedeu::Views::Chars
      deputy     Vedeu::Views::Stream::DSL
      entity     Vedeu::Views::Char
      parent     Vedeu::Views::Streams

      alias_method :content, :value
      alias_method :text,    :value
      alias_method :chars=, :value=
      alias_method :chars?, :value?

      # @!attribute [w] parent
      # @return [Vedeu::Views::Line]
      attr_writer :parent

      # @!attribute [w] value
      # @return [String]
      attr_writer :value

      # Returns a new instance of Vedeu::Views::Stream.
      #
      # @param attributes [Hash]
      # @option attributes client [void]
      # @option attributes colour [Vedeu::Colours::Colour]
      # @option attributes name [String|Symbol]
      # @option attributes parent [Vedeu::Views::Line]
      # @option attributes style [Vedeu::Presentation::Style]
      # @option attributes value [String]
      # @return [Vedeu::Views::Stream]
      def initialize(attributes = {})
        defaults.merge!(attributes).each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # @param child [Vedeu::Views::Stream]
      # @return [Vedeu::Views::Streams]
      def add(child)
        parent.add(child)
      end
      alias_method :<<, :add

      # Returns an array of characters, each element is the escape
      # sequences of colours and styles for this stream, the character
      # itself, and the escape sequences of colours and styles for the
      # parent of the stream ({Vedeu::Views::Line}).
      #
      # @return [Array]
      def chars
        return [] unless value?

        value.value

        # @chars ||= value.chars.map do |char|
        #   Vedeu::Views::Char.new(value:    char,
        #                          name:     name,
        #                          parent:   parent,
        #                          colour:   colour,
        #                          style:    style,
        #                          position: nil)
        # end
      end

      # An object is equal when its values are the same.
      #
      # @param other [Vedeu::Views::Char]
      # @return [Boolean]
      def eql?(other)
        self.class == other.class && value == other.value &&
          colour == other.colour && style == other.style
      end
      alias_method :==, :eql?

      # Returns the size of the content in characters without
      # formatting.
      #
      # @return [Fixnum]
      def size
        value.size
      end

    end # Stream

  end # Views

end # Vedeu
