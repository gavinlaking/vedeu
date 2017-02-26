# frozen_string_literal: true

module Vedeu

  module Editor

    # Manipulate the lines of an Vedeu::Editor::Document.
    #
    # @api private
    #
    class Lines

      include Enumerable
      include Vedeu::Editor::Collection

      # @!attribute [rw] collection
      # @return [String]
      attr_accessor :collection
      alias lines collection

      class << self

        extend Forwardable

        def_delegators Vedeu::Coercers::EditorLines,
                       :coerce

      end # Eigenclass

      # Returns a new instance of Vedeu::Editor::Lines.
      #
      # @param collection [Array<String>|NilClass]
      # @return [Vedeu::Editor::Lines]
      def initialize(collection = nil)
        @collection = collection || []
      end

      # Deletes the character from the line where the cursor is
      # currently positioned.
      #
      # @param y [Integer]
      # @param x [Integer]
      # @return [Vedeu::Editor::Lines]
      def delete_character(y, x)
        collection[y] = line(y).delete_character(x) unless line(y).empty?

        Vedeu::Editor::Lines.coerce(collection)
      end

      # Delete the line from the lines positioned at the given index.
      #
      # @param index [Integer|NilClass]
      # @return [String]
      def delete_line(index = nil)
        Vedeu::Editor::Lines.coerce(Vedeu::Editor::Delete
                                    .from(lines, index, size))
      end

      # Provides iteration over the collection.
      #
      # @macro param_block
      # @return [Enumerator]
      def each(&block)
        collection.each(&block)
      end

      # Insert a character in to a line.
      #
      # @param character [String]
      # @param y [Integer]
      # @param x [Integer]
      # @return [Vedeu::Editor::Lines]
      def insert_character(character, y, x)
        collection[y] = line(y).insert_character(character, x)

        Vedeu::Editor::Lines.coerce(collection)
      end

      # Insert the line on the line below the given index.
      #
      # @param index [Integer|NilClass]
      # @return [Vedeu::Editor::Lines]
      def insert_line(index = nil)
        Vedeu::Editor::Lines.coerce(
          Vedeu::Editor::Insert.into(collection,
                                     Vedeu::Editor::Line.new,
                                     index,
                                     size)
        )
      end

      # Returns the line at the given index.
      #
      # @param index [Integer|NilClass]
      # @return [Vedeu::Editor::Line]
      def line(index = nil)
        return Vedeu::Editor::Line.new unless collection
        return Vedeu::Editor::Line.coerce(collection[-1]) unless index

        Vedeu::Editor::Line.coerce(by_index(index))
      end

      # Return the lines as a string.
      #
      # @return [String]
      def to_s
        collection.map(&:to_s).join
      end
      alias to_str to_s

    end # Lines

  end # Editor

end # Vedeu
