module Vedeu

  module Editor

    # Manipulate the lines of an Vedeu::Editor::Document.
    #
    class Lines

      include Enumerable

      # @!attribute [rw] lines
      # @return [String]
      attr_accessor :lines

      # Coerce a document into a new instance of Vedeu::Editor::Lines.
      #
      # @param document [Array<String>|Vedeu::Editor::Lines]
      # @return [Vedeu::Editor::Lines]
      def self.coerce(document)
        if document.is_a?(self)
          new(document.lines)

        elsif document.is_a?(Array)
          lines = document.map { |line| Vedeu::Editor::Line.coerce(line) }

          new(lines)

        elsif document.is_a?(String)
          lines = document.lines.map(&:chomp).map do |line|
            Vedeu::Editor::Line.coerce(line)
          end

          new(lines)

        else
          new

        end
      end

      # Returns a new instance of Vedeu::Editor::Lines.
      #
      # @param lines [Array<String>|NilClass]
      # @return [Vedeu::Editor::Lines]
      def initialize(lines = nil)
        @lines = lines || []
      end

      # Return a line or collection of lines (if index is a Range).
      #
      # @param index [Fixnum|Range]
      # @return [Vedeu::Editor::Line]
      def [](index)
        lines[index]
      end

      # Deletes the character from the line where the cursor is
      # currently positioned.
      #
      # @param y [Fixnum]
      # @param x [Fixnum]
      # @return [Vedeu::Editor::Lines]
      def delete_character(y, x)
        lines[y] = line(y).delete_character(x)
        Vedeu::Editor::Lines.coerce(lines)
      end

      # Delete the line from the lines positioned at the given index.
      #
      # @param index [Fixnum|NilClass]
      # @return [String]
      def delete_line(index = nil)
        return self if lines.empty? || (index && index <= 0)

        new_lines = if index && index <= size
                      lines.dup.tap { |lines| lines.slice!(index) }

                    else
                      lines.dup.tap(&:pop)

                    end

        Vedeu::Editor::Lines.coerce(new_lines)
      end

      # Provides iteration over the collection.
      #
      # @param block [Proc]
      # @return [Enumerator]
      def each(&block)
        lines.each(&block)
      end

      # Returns a boolean indicating whether there are lines.
      #
      # @return [Boolean]
      def empty?
        size == 0
      end

      # An object is equal when its values are the same.
      #
      # @param other [Vedeu::Editor::Lines]
      # @return [Boolean]
      def eql?(other)
        self.class == other.class && lines == other.lines
      end
      alias_method :==, :eql?

      # Insert a character in to a line.
      #
      # @param character [String]
      # @param y [Fixnum]
      # @param x [Fixnum]
      # @return [Vedeu::Editor::Lines]
      def insert_character(character, y, x)
        lines[y] = line(y).insert_character(character, x)
        Vedeu::Editor::Lines.coerce(lines)
      end

      # Insert the line on the line below the given index.
      #
      # @param line [String]
      # @param index [Fixnum|NilClass]
      # @return [Vedeu::Editor::Lines]
      def insert_line(line, index = nil)
        return self unless line

        Vedeu::Editor::Lines.coerce(Vedeu::Editor::Insert
                                    .into(lines, line, index, size))
      end

      # Returns the line at the given index.
      #
      # @param index [Fixnum|NilClass]
      # @return [Vedeu::Editor::Line]
      def line(index = nil)
        return Vedeu::Editor::Line.new                unless lines
        return Vedeu::Editor::Line.coerce(lines.last) unless index

        indexed = if index <= 0
                    lines.first

                  elsif index && index <= size
                    lines[index]

                  else
                    lines.last

                  end

        Vedeu::Editor::Line.coerce(indexed)
      end

      # Return the number of lines.
      #
      # @return [Fixnum]
      def size
        lines.size
      end

      # Return the lines as a string.
      #
      # @return [String]
      def to_s
        lines.map(&:to_s).join
      end

    end # Line

  end # Editor

end # Vedeu
