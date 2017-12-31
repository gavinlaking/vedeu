# frozen_string_literal: true

module Vedeu

  module Editor

    # Manipulate the lines of an Vedeu::Editor::Document.
    #
    # @api private
    #
    class Insert

      include Vedeu::Common

      # @param (see #initialize)
      # @return (see #insert)
      def self.into(collection, entity, index = nil, size = 0)
        new(collection, entity, index, size).insert
      end

      # Returns a new instance of Vedeu::Editor::Insert.
      #
      # @param collection [String|Vedeu::Editor::Line|Vedeu::Editor::Lines]
      # @param entity [String]
      # @param index [Integer]
      # @param size [Integer]
      # @return [Vedeu::Editor::Insert]
      def initialize(collection, entity, index = nil, size = 0)
        @collection = collection
        @entity     = entity
        @index      = index
        @size       = size
      end

      # @return [String|Vedeu::Editor::Line|Vedeu::Editor::Lines]
      def insert
        return collection.insert(position, entity) if index?

        collection << entity
      end

      protected

      # @!attribute [r] entity
      # @return [String]
      attr_reader :entity

      # @!attribute [r] index
      # @return [Integer]
      attr_reader :index

      # @!attribute [r] size
      # @return [Integer]
      attr_reader :size

      private

      # @!attribute [r] collection
      # @return [String|Vedeu::Editor::Line|Vedeu::Editor::Lines]
      def collection
        if string?(@collection)
          @collection.dup

        else
          @collection

        end
      end

      # @return [Boolean]
      def index?
        numeric?(index)
      end

      # @return [Integer]
      def position
        if index < 0
          0

        elsif index > size
          size

        else
          index

        end
      end

    end # Insert

  end # Editor

end # Vedeu
