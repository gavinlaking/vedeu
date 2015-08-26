module Vedeu

  module Editor

    # Manipulate the lines of an Vedeu::Editor::Document.
    #
    class Lines

      # @!attribute [rw] lines
      # @return [String]
      attr_accessor :lines

      # @param lines [Array<String>]
      # @return [Vedeu::Editor::Lines]
      def initialize(lines)
        @lines = lines || []
      end

      # @param index [Fixnum|NilClass]
      # @return [String]
      def delete_line(index = nil)
        if lines.empty? || (index && index <= 0)
          lines

        elsif index && index <= size
          @lines = lines.dup.tap { |lines| lines.slice!(index) }

        else
          @lines = lines.dup.tap { |lines| lines.pop }

        end
      end

      # @param line [String]
      # @param index [Fixnum|NilClass]
      # @return [String]
      def insert_line(line, index = nil)
        return lines unless line

        if index
          if index <= 0
            @lines = lines.insert(0, line)

          elsif index >= size
            @lines = lines << line

          else
            @lines = lines.insert(index, line)

          end
        else
          @lines = lines + [line]

        end
      end

      # @param index [Fixnum|NilClass]
      # @return [Vedeu::Editor::Line]
      def line(index = nil)
        return Vedeu::Editor::Line.new             unless lines
        return Vedeu::Editor::Line.new(lines.last) unless index

        if index <= 0
          Vedeu::Editor::Line.new(lines.first)

        elsif index && index <= size
          Vedeu::Editor::Line.new(lines[index])

        else
          Vedeu::Editor::Line.new(lines.last)

        end
      end

      private

      # @return [Fixnum]
      def size
        lines.size
      end

    end # Line

  end # Editor

end # Vedeu
