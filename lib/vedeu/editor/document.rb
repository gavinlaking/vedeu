module Vedeu

  module Editor

    # A collection of keypresses ordered by input.
    #
    class Document

      include Vedeu::Repositories::Model
      extend Forwardable

      def_delegators :border,
                     :bx,
                     :bxn,
                     :by,
                     :byn,
                     :height,
                     :width

      def_delegators :cursor,
                     :bol,
                     :ox,
                     :oy,
                     :x,
                     :y

      def_delegators :interface,
                     :colour,
                     :style

      # @!attribute [r] attributes
      # @return [Hash]
      attr_reader :attributes

      # @!attribute [rw] data
      # @return [String]
      attr_accessor :data

      # @!attribute [rw] name
      # @return [String|Symbol]
      attr_accessor :name

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

      # Clear the document content in the terminal.
      #
      # @return [void]
      def clear
        Vedeu.trigger(:_clear_view_content_, name)
      end

      # Deletes the character from the line where the cursor is
      # currently positioned.
      #
      # @return [Vedeu::Editor::Document]
      def delete_character
        @lines = lines.delete_character(y, x - 1)

        left

        refresh
      end

      # Delete a line.
      #
      # @return [Vedeu::Editor::Document]
      def delete_line
        @lines = lines.delete_line(y)

        up
      end

      # Move the virtual cursor down.
      #
      # @return [Vedeu::Editor::Document]
      def down
        cursor.down

        refresh
      end

      # Returns the document as a string with line breaks if there is
      # more than one line.
      #
      # @return [String]
      def execute
        command = lines.map(&:to_s).join("\n")

        reset!

        clear

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
      end

      # Insert an empty line.
      #
      # @return [Vedeu::Editor::Document]
      def insert_line
        down

        @lines = lines.insert_line(Vedeu::Editor::Line.new, y)

        bol

        refresh
      end

      # Move the virtual cursor left.
      #
      # @return [Vedeu::Editor::Document]
      def left
        cursor.left

        refresh
      end

      # Returns the current line from the collection of lines.
      #
      # @return [Array<String|void>]
      def line
        lines.line(y)
      end

      # Returns the collection of lines which constitutes the document
      # content.
      #
      # @return [Array<String|void>]
      def lines
        @lines ||= Vedeu::Editor::Lines.coerce(data)
      end

      # Render the document content in the terminal.
      #
      # @return [void]
      def render
        clear

        Vedeu::Output::Output.render(output)
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
      # render the view.
      #
      # @return [Vedeu::Editor::Document]
      def refresh
        store

        render

        self
      end

      # Move the virtual cursor right.
      #
      # @return [Vedeu::Editor::Document]
      def right
        cursor.right

        refresh
      end

      # Move the virtual cursor up.
      #
      # @return [Vedeu::Editor::Document]
      def up
        cursor.up

        refresh
      end

      private

      # Retrieve the dimensions of the document from the interface of
      # the same name.
      #
      # @return [Vedeu::Borders::Border]
      def border
        @border ||= Vedeu.borders.by_name(name)
      end

      # @return [Vedeu::Models::Interface]
      def interface
        @interface ||= Vedeu.interfaces.by_name(name)
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

      # Return the data needed to render the document.
      #
      # @return [String]
      def output
        out = []

        visible_lines.each_with_index do |line, y_index|
          line.chars.each_with_index do |char, x_index|
            position = [(by + y_index), (bx + x_index)]

            out << Vedeu::Views::Char.new(value:    char,
                                          parent:   interface,
                                          position: position)
          end
        end

        cursor.store

        out.flatten
      end

      # Return a virtual cursor to track the cursor position within
      # the document.
      #
      # @return [Vedeu::Editor::Cursor]
      def cursor
        @cursor ||= Vedeu::Editor::Cursor.new(y:    0,
                                              x:    0,
                                              by:   by,
                                              bx:   bx,
                                              byn:  byn,
                                              bxn:  bxn,
                                              name: name)
      end

      # Return only the visible lines for the document based on the
      # current virtual cursor position.
      #
      # @return [Vedeu::Editor::Lines]
      def visible_lines
        Vedeu::Editor::Cropper.new(lines:  lines,
                                   height: height,
                                   width:  width,
                                   ox:     ox,
                                   oy:     oy).cropped
      end

    end # Document

  end # Editor

end # Vedeu
