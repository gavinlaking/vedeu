module Vedeu

  module Editor

    # Manipulate a single line of an Vedeu::Editor::Document.
    #
    class Line

      # @!attribute [rw] line
      # @return [String]
      attr_accessor :line
      alias_method :to_s, :line

      # Coerce a line into a new instance of Vedeu::Editor::Line.
      #
      # @param line [String|Vedeu::Editor::Line]
      # @return (see #initialize)
      def self.coerce(line)
        return line      if line.is_a?(self)
        return new(line) if line.is_a?(String)

        new
      end

      # Returns a new instance of Vedeu::Editor::Line.
      #
      # @param line [String|NilClass]
      # @return [Vedeu::Editor::Line]
      def initialize(line = nil)
        @line = line || ''
      end

      # Return a character or collection of characters (if index is a
      # Range).
      #
      # @param index [Fixnum|Range]
      # @return [String]
      def [](index)
        line[index]
      end

      # Return the character from the line positioned at the given
      # index.
      #
      # @param index [Fixnum|NilClass]
      # @return [String|NilClass]
      def character(index = nil)
        return ''       if line && line.empty?
        return line[-1] unless index

        if index <= 0
          line[0]

        elsif index && index <= size
          line[index]

        else
          line[-1]

        end
      end

      # Delete the character from the line positioned at the given
      # index.
      #
      # @param index [Fixnum|NilClass]
      # @return [String]
      def delete_character(index = nil)
        return self if line.empty? || (index && index < 0)

        new_line = if index && index <= size
                     line.dup.tap { |line| line.slice!(index) }

                   else
                     line.chop

                   end

        Vedeu::Editor::Line.coerce(new_line)
      end

      # Returns a boolean indicating whether there are characters on
      # this line.
      #
      # @return [Boolean]
      def empty?
        line.empty?
      end

      # An object is equal when its values are the same.
      #
      # @param other [Vedeu::Editor::Line]
      # @return [Boolean]
      def eql?(other)
        self.class == other.class && line == other.line
      end
      alias_method :==, :eql?

      # Insert the character on the line positioned at the given
      # index.
      #
      # @param character [String]
      # @param index [Fixnum|NilClass]
      # @return [Vedeu::Editor::Line]
      def insert_character(character, index = nil)
        return self unless character

        Vedeu::Editor::Line.coerce(Vedeu::Editor::Insert
                                   .into(line, character, index, size))
      end

      # Return the size of the line in characters.
      #
      # @return [Fixnum]
      def size
        line.size
      end

    end # Line

  end # Editor

end # Vedeu
