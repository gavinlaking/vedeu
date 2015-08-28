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
          lines = document.map do |line|
            if line.is_a?(Vedeu::Editor::Line)
              line

            elsif line.is_a?(String)
              Vedeu::Editor::Line.coerce(line)

            else
              Vedeu::Editor::Line.new

            end
          end

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

      # Deletes the character from the line where the cursor is currently
      # positioned.
      #
      # @param character [String]
      # @param y [Fixnum]
      # @param x [Fixnum]
      # @return [Vedeu::Editor::Lines]
      def delete_character(y, x)
        new_line  = line(y).delete_character(x)
        # new_lines = lines[y] = new_line
        # Vedeu::Editor::Lines.coerce(new_lines)
      end

      # Delete the line from the lines positioned at the given index.
      #
      # @param index [Fixnum|NilClass]
      # @return [String]
      def delete_line(index = nil)
        if lines.empty? || (index && index <= 0)
          self

        elsif index && index <= size
          new_lines = lines.dup.tap { |lines| lines.slice!(index) }
          Vedeu::Editor::Lines.coerce(new_lines)

        else
          new_lines = lines.dup.tap(&:pop)
          Vedeu::Editor::Lines.coerce(new_lines)

        end
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
        new_line = line(y).insert_character(character, x)
        # new_lines = lines[y] = new_line
        # Vedeu::Editor::Lines.coerce(new_lines)
      end

      # Insert the line on the line below the given index.
      #
      # @param line [String]
      # @param index [Fixnum|NilClass]
      # @return [Vedeu::Editor::Lines]
      def insert_line(line, index = nil)
        return self unless line

        if index
          if index <= 0
            new_lines = lines.insert(0, line)
            Vedeu::Editor::Lines.coerce(new_lines)

          elsif index >= size
            new_lines = lines << line
            Vedeu::Editor::Lines.coerce(new_lines)

          else
            new_lines = lines.insert(index, line)
            Vedeu::Editor::Lines.coerce(new_lines)

          end
        else
          new_lines = lines << line
          Vedeu::Editor::Lines.coerce(new_lines)

        end
      end

      # Returns the line at the given index.
      #
      # @param index [Fixnum|NilClass]
      # @return [Vedeu::Editor::Line]
      def line(index = nil)
        return Vedeu::Editor::Line.new                unless lines
        return Vedeu::Editor::Line.coerce(lines.last) unless index

        if index <= 0
          Vedeu::Editor::Line.coerce(lines.first)

        elsif index && index <= size
          Vedeu::Editor::Line.coerce(lines[index])

        else
          Vedeu::Editor::Line.coerce(lines.last)

        end
      end

      # Return the number of lines.
      #
      # @return [Fixnum]
      def size
        lines.size
      end

    end # Line

  end # Editor

end # Vedeu
