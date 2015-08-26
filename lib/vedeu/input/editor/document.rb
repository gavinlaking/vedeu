module Vedeu

  module Editor

    # A collection of keypresses ordered by input.
    #
    class Document

      include Vedeu::Model
      extend Forwardable

      def_delegators :border,
                     :bx,
                     :by

      # @!attribute [r] attributes
      # @return [Hash]
      attr_reader :attributes

      # @!attribute [rw] data
      # @return [String]
      attr_accessor :data

      # @!attribute [rw] name
      # @return [String]
      attr_accessor :name

      # Returns a new instance of Vedeu::Editor::Document.
      #
      # @param attributes [Hash]
      # @option attributes data [String]
      # @option attributes name [String]
      # @option attributes repository [Vedeu::Repository]
      # @option attributes x [Fixnum]
      # @option attributes y [Fixnum]
      # @return [Vedeu::Editor::Document]
      def initialize(attributes = {})
        @attributes = defaults.merge!(attributes)

        @attributes.each do |key, value|
          instance_variable_set("@#{key}", value || defaults[key])
        end

        @border = Vedeu.borders.by_name(@name)
      end

      # Deletes the character from the line where the cursor is currently
      # positioned.
      #
      # @return [Vedeu::Editor::Document]
      def delete_character
        if line_empty? || x == 0
          line

        elsif x > 0 && x <= (line_size - 1)
          new_lines = lines.dup
          new_line  = new_lines[y].dup
          new_line.slice!(x)
          new_lines[y] = new_line

          left

          @data = new_lines.join("\n")
        end

        store
      end

      # Delete a line.
      #
      # @return [Vedeu::Editor::Document]
      def delete_line
        new_lines = lines.dup
        new_lines.slice!(y)
        @data = new_lines.join("\n")

        store
      end

      # Move the current virtual cursor down by one line.
      #
      # @return [Fixnum]
      def down
        if y >= (lines_size - 1)
          @y = lines_size - 1

        else
          @y += 1

        end

        store
      end

      # @return [Fixnum]
      def goto_bof
        @y = 0
      end

      # @return [Fixnum]
      def goto_bol
        @x = 0
      end

      # @return [Fixnum]
      def goto_eof
        @y = lines.size - 1
      end

      # @return [Fixnum]
      def goto_eol
        @x = line.size - 1
      end

      # Inserts the given character in to the line where the cursor is currently
      # positioned.
      #
      # @param character [String]
      # @return [Vedeu::Editor::Document]
      def insert_character(character)
        new_lines = lines.dup
        if line_empty? || x == (line_size - 1)
          new_line =  new_lines[y] ? new_lines[y].dup : ''
          new_line << character

        else
          new_line = new_lines[y].insert(x, character)

        end

        new_lines[y] = new_line
        @data = new_lines.join("\n")

        right

        store
      end

      # Insert an empty line.
      #
      # @return [Vedeu::Editor::Document]
      def insert_line
        goto_bol

        new_lines = lines.dup
        new_lines.insert(y + 1, '')

        @y    = y + 1
        @data = new_lines.join("\n")

        store
      end

      # Move the current virtual cursor to the left.
      #
      # @return [Fixnum]
      def left
        if x <= 0
          @x = 0

        elsif x >= (line_size - 1)
          @x = (line_size - 1) - 1

        else
          @x -= 1

        end

        store
      end

      # @return [Array<String|void>]
      def line
        present?(lines[y]) ? lines[y] : ''
      end


      # @return [Array<String|void>]
      def lines
        present?(data) ? data.lines.map(&:chomp) : []
      end

      # @return [void]
      def render
        Vedeu.buffers.by_name(name).clear

        Vedeu::Output.render(border.render)

        Vedeu::Direct.write(value: @data, x: bx, y: by)
      end

      # Move the current virtual cursor to the right.
      #
      # @return [Fixnum]
      def right
        if x >= (line_size - 1)
          @x = line_size - 1

        else
          @x += 1

        end

        store
      end

      # @return [Vedeu::Editor::Document]
      def store
        super

        cursor.x = x
        cursor.y = y
        cursor.store
        cursor.render

        render

        self
      end

      # Move the current virtual cursor up by one line.
      #
      # @return [Fixnum]
      def up
        if y <= 0
          @y = 0

        elsif y >= (lines_size - 1)
          @y = (lines_size - 1) - 1

        else
          @y -= 1

        end

        store
      end

      # Return the current virtual cursor position.
      #
      # @return [Fixnum]
      def x
        if @x <= 0
          @x = 0

        elsif @x >= (line_size - 1)
          @x = line_size - 1

        else
          @x

        end
      end

      # Return the current virtual cursor position.
      #
      # @return [Fixnum]
      def y
        if @y <= 0
          @y = 0

        elsif @y >= (lines_size - 1)
          @y = lines_size - 1

        else
          @y

        end
      end

      protected

      # @!attribute [r] border
      # @return [Vedeu::Border]
      attr_reader :border

      private

      # @return [Vedeu::Cursor]
      def cursor
        @cursor = Vedeu.cursors.by_name(name)
      end

      # Returns the default options/attributes for this class.
      #
      # @return [Hash]
      def defaults
        {
          data:       '',
          name:       nil,
          repository: Vedeu.documents,
          x:          0,
          y:          0,
        }
      end

      # @return [Boolean]
      def lines_empty?
        lines && lines.empty?
      end

      # @return [Fixnum]
      def lines_size
        return 0 if lines_empty?

        lines.size
      end

      # @return [Boolean]
      def line_empty?
        line && line.empty?
      end

      # @return [Fixnum]
      def line_size
        return 0 if line_empty?

        line.size
      end

    end # Document

  end # Editor

end # Vedeu
