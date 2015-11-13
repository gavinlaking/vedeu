module Vedeu

  module Editor

    # A collection of keypresses ordered by input.
    #
    # @api private
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
      # @note
      #   If a particular key is missing from the attributes
      #   parameter, then it is added with the respective value from
      #   #defaults.
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

      # Deletes the character from the line where the cursor is
      # currently positioned.
      #
      # @return [Vedeu::Editor::Document]
      def delete_character
        return self if document_start?

        if first_char? && y > 0
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

        cursor.x = line.size

        cursor.refresh

        refresh
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

        refresh
      end

      # Returns the current line from the collection of lines.
      #
      # @param index [Fixnum]
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

        cursor.refresh

        refresh
      end

      # Store the document in the documents repository, clear and
      # send the content to the terminal.
      #
      # @return [Vedeu::Editor::Document]
      def refresh
        store

        Vedeu.trigger(:_clear_view_content_, name)

        Vedeu.buffer_update(output)

        Vedeu.direct_write(output.map(&:to_s).join)

        self
      end

      # Move the virtual cursor left.
      #
      # @return [Vedeu::Editor::Document]
      def left
        return self if first_char?

        cursor.left.refresh

        self
      end

      # Move the virtual cursor right.
      #
      # @return [Vedeu::Editor::Document]
      def right
        return self if last_char?

        cursor.right.refresh

        self
      end

      # Move the virtual cursor up.
      #
      # @return [Vedeu::Editor::Document]
      def up
        return self if first_line?

        cursor.up(prev_line_size).refresh

        self
      end

      # Move the virtual cursor down.
      #
      # @return [Vedeu::Editor::Document]
      def down
        return self if last_line?

        cursor.down(next_line_size).refresh

        self
      end

      private

      # @return [Boolean]
      def document_start?
        first_char? && first_line?
      end

      # Return a virtual cursor to track the cursor position within
      # the document.
      #
      # @return [Vedeu::Editor::Cursor]
      def cursor
        @cursor ||= Vedeu::Editor::Cursor.new(name: name)
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

      # @return [Boolean]
      def first_char?
        x - 1 < 0
      end

      # @return [Boolean]
      def first_line?
        y - 1 < 0
      end

      # @return [Boolean]
      def last_char?
        x + 1 > line.size
      end

      # @return [Boolean]
      def last_line?
        y + 1 >= lines.size
      end

      # @return [Fixnum]
      def next_line_size
        line(y + 1).size
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

      # @return [Fixnum]
      def prev_line_size
        line(y - 1).size
      end

    end # Document

  end # Editor

end # Vedeu
