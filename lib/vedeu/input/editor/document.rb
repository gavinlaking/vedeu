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

      # @!attribute [r] x
      # @return [Fixnum]
      attr_reader :x

      # @!attribute [r] y
      # @return [Fixnum]
      attr_reader :y

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
        if line_empty? || x_position == 0
          line

        elsif x_position > 0 && x_position <= (line_size - 1)
          new_lines = lines.dup
          new_line  = new_lines[y_position].dup
          new_line.slice!(x_position)
          new_lines[y_position] = new_line
          @lines = new_lines
          @data  = @lines.join("\n")

          left

        end

        render

        self
      end

      # Delete a line.
      #
      # @return [void]
      def delete_line
      end

      # Inserts the given character in to the line where the cursor is currently
      # positioned.
      #
      # @param character [String]
      # @return [Vedeu::Editor::Document]
      def insert_character(character)
        new_lines = lines.dup
        if line_empty? || x_position == (line_size - 1)
          new_line =  new_lines[y_position] ? new_lines[y_position].dup : ''
          new_line << character

        else
          new_line = new_lines[y_position].insert(x_position, character)

        end

        new_lines[y_position] = new_line
        @lines = new_lines
        @data  = @lines.join("\n")

        right

        render

        self
      end

      # Insert an empty line.
      #
      # @return [void]
      def insert_line
        new_lines = lines.dup
        new_lines[y_position + 1] = ''
        @lines = new_lines
        @data = @lines.join("\n")

        new_line

        render

        self
      end

      # @return [Array<String|void>]
      def line
        @line = present?(lines[y]) ? lines[y] : ''
      end

      # @return [Array<String|void>]
      def lines
        @lines ||= present?(data) ? data.lines.map(&:chomp) : []
      end

      # Return the current virtual cursor position.
      #
      # @return [Fixnum]
      def x_position
        if x <= 0
          @x = 0

        elsif x >= (line_size - 1)
          @x = line_size - 1

        else
          @x

        end
      end

      # Return the current virtual cursor position.
      #
      # @return [Fixnum]
      def y_position
        if y <= 0
          @y = 0

        elsif y >= (lines_size - 1)
          @y = lines_size - 1

        else
          @y

        end
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
      end

      # Set the x coordinate to the beginning of the line and the y coordinate
      # to the next line.
      #
      # @return [void]
      def new_line
        @x = bx
        @y = y + 1
      end

      # @return [String]
      def render
        store

        view_line_collection = Vedeu::Views::Lines.new

        @data.lines.map(&:chomp).each do |line|
          stream = Vedeu::Views::Stream.new(value: line)
          view_line_collection << Vedeu::Views::Line.new(value: stream)
        end

        Vedeu::Cursor.new(name: name, x: cursor_x, y: cursor_y).store

        Vedeu::Views::View.new(name:  name,
                               value: view_line_collection).store_immediate
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
      end

      protected

      # @!attribute [r] border
      # @return [Vedeu::Border]
      attr_reader :border

      private

      # @return [Vedeu::Cursor]
      # @see Vedeu::Cursors#by_name
      def cursor
        Vedeu.cursors.by_name(name)
      end

      # @return [Fixnum]
      def cursor_x
        bx + x + 1
      end

      # @return [Fixnum]
      def cursor_y
        by + y
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
