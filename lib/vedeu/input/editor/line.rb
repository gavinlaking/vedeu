module Vedeu

  module Editor

    # Manipulate a single line of an Vedeu::Editor::Document.
    #
    class Line

      # @!attribute [rw] line
      # @return [String]
      attr_accessor :line

      # Returns a new instance of Vedeu::Editor::Line.
      #
      # @param line [String|NilClass]
      # @return [Vedeu::Editor::Line]
      def initialize(line = nil)
        @line = line || ''
      end

      # Return the character from the line positioned at the given index.
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

      # Delete the character from the line positioned at the given index.
      #
      # @param index [Fixnum|NilClass]
      # @return [String]
      def delete_character(index = nil)
        if line.empty? || (index && index <= 0)
          self

        elsif index
          if index >= size
            @line = line.chop
          else
            @line = line.dup.tap { |line| line.slice!(index) }
          end
        else
          @line = line.chop

        end

        self
      end

      # An object is equal when its values are the same.
      #
      # @param other [Vedeu::Views::Char]
      # @return [Boolean]
      def eql?(other)
        self.class == other.class && line == other.line
      end
      alias_method :==, :eql?

      # Insert the character on the line positioned at the given index.
      #
      # @param character [String]
      # @param index [Fixnum|NilClass]
      # @return [String]
      def insert_character(character, index = nil)
        if index
          if index <= 0
            @line = line.insert(0, character)

          elsif index >= size
            @line = line << character

          else
            @line = line.insert(index, character)

          end
        else
          @line = line + character

        end

        self
      end

      private

      # Return the size of the line in characters.
      #
      # @return [Fixnum]
      def size
        line.size
      end

    end # Line

  end # Editor

end # Vedeu
