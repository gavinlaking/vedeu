module Vedeu

  module Editor

    # A collection of keypresses ordered by input.
    #
    class Document

      include Vedeu::Repositories::Model
      extend Forwardable

      def_delegators :cursor,
                     :ox,
                     :oy,
                     :x,
                     :y

      # @!attribute [r] attributes
      # @return [Hash]
      attr_reader :attributes

      # @!attribute [rw] data
      # @return [String]
      attr_accessor :data

      # @!attribute [rw] name
      # @return [String|Symbol]
      attr_accessor :name

      # Store an instance of this class with its repository.
      #
      # @param (see #initialize)
      # @return (see #initialize)
      def self.store(attributes = {})
        new(attributes).store
      end

      # Returns a new instance of Vedeu::Editor::Document.
      #
      # @param attributes [Hash]
      # @option attributes data [String]
      # @option attributes name [String|Symbol]
      # @option attributes repository
      #   [Vedeu::Repositories::Repository]
      # @return [Vedeu::Editor::Document]
      def initialize(attributes = {})
        defaults.merge!(attributes).each do |key, value|
          instance_variable_set("@#{key}", value || defaults.fetch(key))
        end
      end

      # Deletes the character from the line where the cursor is
      # currently positioned.
      #
      # @return [Vedeu::Editor::Document]
      def delete_character
        if x - 1 < 0 && y == 0
          bol

        elsif x - 1 < 0 && y > 0
          delete_line

          return

        else
          @lines = lines.delete_character(y, x - 1)

          left

        end

        refresh
      end

      # Delete a line.
      #
      # @return [Vedeu::Editor::Document]
      def delete_line
        @lines = lines.delete_line(y)

        up

        eol

        refresh
      end

      # Returns the document as a string with line breaks if there is
      # more than one line.
      #
      # @return [String]
      def execute
        command = lines.map(&:to_s).join("\n".freeze)

        reset!

        Vedeu.trigger(:_clear_view_content_, name)

        Vedeu.trigger(:_command_, command)

        command
      end

      # Inserts the given character in to the line where the cursor is
      # currently positioned.
      #
      # @param character [String|Symbol]
      # @return [Vedeu::Editor::Document]
      def insert_character(character)
        return self if character.is_a?(Symbol)

        @lines = lines.insert_character(character, y, x)

        right

        refresh
      end

      # Insert an empty line.
      #
      # @return [Vedeu::Editor::Document]
      def insert_line
        @lines = lines.insert_line(y + 1)

        down

        bol

        refresh
      end

      # Returns the current line from the collection of lines.
      #
      # @return [Array<String|void>]
      def line(index = y)
        lines.line(index)
      end

      # Returns the collection of lines which constitutes the document
      # content.
      #
      # @return [Array<String|void>]
      def lines
        @lines ||= Vedeu::Editor::Lines.coerce(data)
      end

      # Reset the document to the empty state.
      #
      # @return [Vedeu::Editor::Document]
      def reset!
        @cursor = cursor.reset!

        @lines = defaults[:data]

        refresh
      end

      # Store the document in the documents repository, clear and
      # send the content to the terminal.
      #
      # @return [Vedeu::Editor::Document]
      def refresh
        store

        Vedeu.trigger(:_clear_view_content_, name)

        Vedeu.render_output(output)

        cursor.refresh

        self
      end

      # Move the virtual cursor left.
      #
      # @return [Vedeu::Editor::Document]
      def left
        return self if x - 1 < 0

        cursor.left.refresh
      end

      # Move the virtual cursor right.
      #
      # @return [Vedeu::Editor::Document]
      def right
        return self if x + 1 > line.size

        cursor.right.refresh
      end

      # Move the virtual cursor up.
      #
      # @return [Vedeu::Editor::Document]
      def up
        return self if y - 1 < 0

        cursor.up.refresh

        if x > line(y).size
          eol

        else
          refresh

        end
      end

      # Move the virtual cursor down.
      #
      # @return [Vedeu::Editor::Document]
      def down
        return self if y + 1 >= lines.size

        cursor.down.refresh

        reposition_cursor_x!

        self
      end

      private

      # Repositions the x coordinate of the virtual cursor to the end
      # of the line if the x coordinate is beyond the end of the line.
      #
      # This is used when the cursor moves up or down, moving from a
      # long line to a shorter line.
      #
      # @return [Vedeu::Editor::Cursor]
      def reposition_cursor_x!
        if x > line.size
          cursor.x = line.size
          cursor.refresh
        end
      end

      # Returns the default options/attributes for this class.
      #
      # @return [Hash<Symbol => void|Symbol]
      def defaults
        {
          data:       Vedeu::Editor::Lines.new([Vedeu::Editor::Line.new]),
          name:       nil,
          repository: Vedeu.documents,
        }
      end

      # Return the data needed to render the document, based on the
      # current virtual cursor position. This output may be a cropped
      # representation of the full document depending on the size of
      # the interface.
      #
      # @return [Array<Vedeu::Views::Char>]
      def output
        Vedeu::Editor::Cropper.new(lines: lines,
                                   name:  name,
                                   ox:    ox,
                                   oy:    oy).viewport
      end

      # Return a virtual cursor to track the cursor position within
      # the document.
      #
      # @return [Vedeu::Editor::Cursor]
      def cursor
        @cursor ||= Vedeu::Editor::Cursor.new(name: name)
      end

    end # Document

  end # Editor

end # Vedeu
