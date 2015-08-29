module Vedeu

  module Editor

    # A collection of keypresses ordered by input.
    #
    class Document

      include Vedeu::Model
      extend Forwardable

      def_delegators :border,
                     :bx,
                     :bxn,
                     :by,
                     :byn,
                     :width

      def_delegators :virtual_cursor,
                     :bol,
                     :down,
                     :left,
                     :origin,
                     :right,
                     :up,
                     :x,
                     :y

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
          instance_variable_set("@#{key}", value || defaults.fetch(key))
        end
      end

      # @return [void]
      def clear
        Vedeu::Direct.write(value: clear_output, x: bx, y: by)
      end

      # Deletes the character from the line where the cursor is currently
      # positioned.
      #
      # @return [Vedeu::Editor::Document]
      def delete_character
        @lines = lines.delete_character(y, x)

        left

        store
      end

      # Delete a line.
      #
      # @return [Vedeu::Editor::Document]
      def delete_line
        @lines = lines.delete_line(y)

        up

        store
      end

      # Inserts the given character in to the line where the cursor is currently
      # positioned.
      #
      # @param character [String|Symbol]
      # @return [Vedeu::Editor::Document]
      def insert_character(character)
        return self if character.is_a?(Symbol)

        @lines = lines.insert_character(character, y, x)

        right

        store
      end

      # Insert an empty line.
      #
      # @return [Vedeu::Editor::Document]
      def insert_line
        @lines = lines.insert_line(Vedeu::Editor::Line.new, y + 1)

        down

        bol

        store
      end

      # @return [Array<String|void>]
      def line
        lines.line(y)
      end

      # @return [Array<String|void>]
      def lines
        @lines ||= if present?(data)
                     Vedeu::Editor::Lines.coerce(data)

                   else
                     defaults[:data]

                   end
      end

      # @return [void]
      def render
        Vedeu::Direct.write(value: output, x: bx, y: by)
      end

      # Reset the document to the empty state.
      #
      # @return [Vedeu::Editor::Document]
      def reset!
        @lines = defaults[:data]

        store
      end

      # Returns the document as a string with line breaks if there is more than
      # one line.
      #
      # @return [String]
      def retrieve
        lines.map(&:to_s).join("\n")
      end

      private

      # @return [Vedeu::Border]
      def border
        @border ||= Vedeu.borders.by_name(name)
      end

      # @return [String]
      def clear_output
        clear_output = ''

        (by..byn).each do |y|
          clear_output << "\e[#{y};#{bx}H" + (' ' * width)
        end

        clear_output << "\e[#{by};#{bx}H"
      end

      # Returns the default options/attributes for this class.
      #
      # @return [Hash]
      def defaults
        {
          data:       Vedeu::Editor::Lines.new([Vedeu::Editor::Line.new]),
          name:       nil,
          repository: Vedeu.documents,
        }
      end

      # @return [String]
      def output
        output = ''

        lines.each_with_index do |line, y_index|
          output << Vedeu::Position.new((by + y_index), bx).to_s + line.to_s
        end

        virtual_cursor_adjust!

        output << virtual_cursor.to_s

        output
      end

      # @return [Vedeu::VirtualCursor]
      def virtual_cursor
        @virtual_cursor ||= Vedeu::Editor::VirtualCursor.new(y:  0,
                                                             x:  0,
                                                             by: by,
                                                             bx: bx)
      end

      # Adjust the position of the virtual cursor.
      #
      # @return [TrueClass]
      def virtual_cursor_adjust!
        if virtual_cursor.x > lines.line(y).size
          virtual_cursor.x = lines.line(y).size
        end

        virtual_cursor.y = lines.size if virtual_cursor.y > lines.size

        true
      end

    end # Document

  end # Editor

end # Vedeu
