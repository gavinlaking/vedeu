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
      alias_method :line, :collection
      alias_method :to_s, :collection

      class << self

        include Vedeu::Common

        # Coerce a line into a new instance of Vedeu::Editor::Line.
        #
        # @param collection [String|Vedeu::Editor::Line]
        # @return (see #initialize)
        def coerce(collection)
          return collection      if collection.is_a?(self)
          return new(collection) if string?(collection)

          new
        end

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
      # @param index [Fixnum|NilClass]
      # @return [String|NilClass]
      def character(index = nil)
        return ''             if collection && collection.empty?
        return collection[-1] unless index

        by_index(index)
      end

      # Delete the character from the line positioned at the given
      # index.
      #
      # @param index [Fixnum|NilClass]
      # @return [String]
      def delete_character(index = nil)
        Vedeu::Editor::Line.coerce(Vedeu::Editor::Delete
                                   .from(line, index, size))
      end

      # Insert the character on the line positioned at the given
      # index.
      #
      # @param character [String]
      # @param index [Fixnum|NilClass]
      # @return [Vedeu::Editor::Line]
      def insert_character(character, index = nil)
        return self unless character

        Vedeu::Editor::Line.coerce(Vedeu::Editor::Insert
                                   .into(collection, character, index, size))
      end

    end # Line

  end # Editor

end # Vedeu
