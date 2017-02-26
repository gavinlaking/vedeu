# frozen_string_literal: true

module Vedeu

  module Editor

    # Manipulate a single line of an Vedeu::Editor::Document.
    #
    # @api private
    #
    class Line

      include Vedeu::Editor::Collection

      # @!attribute [rw] collection
      # @return [String]
      attr_accessor :collection
      alias line collection
      alias to_s collection

      class << self

        extend Forwardable

        def_delegators Vedeu::Coercers::EditorLine,
                       :coerce

      end # Eigenclass

      # Returns a new instance of Vedeu::Editor::Line.
      #
      # @param collection [String|NilClass]
      # @return [Vedeu::Editor::Line]
      def initialize(collection = nil)
        @collection = collection || ''
      end

      # Return the character at the given index.
      #
      # @param index [Integer|NilClass]
      # @return [String|NilClass]
      def character(index = nil)
        return ''             if collection && collection.empty?
        return collection[-1] unless index

        by_index(index)
      end

      # Delete the character from the line positioned at the given
      # index.
      #
      # @param index [Integer|NilClass]
      # @return [String]
      def delete_character(index = nil)
        Vedeu::Editor::Line.coerce(Vedeu::Editor::Delete
                                   .from(line, index, size))
      end

      # Insert the character on the line positioned at the given
      # index.
      #
      # @param character [String]
      # @param index [Integer|NilClass]
      # @return [Vedeu::Editor::Line]
      def insert_character(character, index = nil)
        return self unless character

        Vedeu::Editor::Line.coerce(Vedeu::Editor::Insert
                                   .into(collection, character, index, size))
      end

    end # Line

  end # Editor

end # Vedeu
