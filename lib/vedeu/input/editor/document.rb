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

      def_delegators :virtual_cursor,
                     :down,
                     :left,
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

      # Deletes the character from the line where the cursor is currently
      # positioned.
      #
      # @return [Vedeu::Editor::Document]
      def delete_character
        lines.delete_character(y, x)
      end

      # Delete a line.
      #
      # @return [Vedeu::Editor::Document]
      def delete_line
        lines.delete_line(y)
      end

      # Inserts the given character in to the line where the cursor is currently
      # positioned.
      #
      # @param character [String|Symbol]
      # @return [Vedeu::Editor::Document]
      def insert_character(character)
        return self if character.is_a?(Symbol)

        new_lines = lines.insert_character(character, y, x)

        Vedeu.log(message: "#{new_lines.inspect}")

        store

        new_lines
      end

      # Insert an empty line.
      #
      # @return [Vedeu::Editor::Document]
      def insert_line
        new_lines = lines.insert_line(Vedeu::Editor::Line.new, y)

        Vedeu.log(message: "#{new_lines.inspect}")

        store

        new_lines
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
          defaults.fetch(data)

        end
      end

      # @return [void]
      def render
        # Vedeu.buffers.by_name(name).clear
        # Vedeu::Output.render(border.render)

        value = lines.flat_map { |line| line.to_chars }.map(&:to_s)

        Vedeu::Direct.write(value: value, x: bx, y: by)
      end

      # @return [Vedeu::Editor::Document]
      def store
        virtual_cursor.x = x
        virtual_cursor.y = y

        super

        # cursor.store
        # cursor.render

        # render

        # self
      end

      protected

      private

      # @return [Vedeu::Border]
      def border
        @border ||= Vedeu.borders.by_name(name)
      end

      # @return [Vedeu::Cursor]
      def cursor
        @cursor = Vedeu.cursors.by_name(name)
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

      # @return [Vedeu::VirtualCursor]
      def virtual_cursor
        @virtual_cursor ||= Vedeu::Editor::VirtualCursor.new(y: 0, x: 0)
      end

    end # Document

  end # Editor

end # Vedeu
