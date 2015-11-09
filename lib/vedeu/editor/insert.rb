module Vedeu

  module Editor

    # Manipulate the lines of an Vedeu::Editor::Document.
    #
    # @api private
    #
    class Insert

      # @param (see #initialize)
      # @return [Vedeu::Editor::Line|Vedeu::Editor::Lines]
      def self.into(collection, entity, index = nil, size = 0)
        new(collection, entity, index, size).insert
      end

      # Returns a new instance of Vedeu::Editor::Insert.
      #
      # @param collection [Vedeu::Editor::Line|Vedeu::Editor::Lines]
      # @param entity [String]
      # @param index [Fixnum]
      # @param size [Fixnum]
      # @return [Vedeu::Editor::Insert]
      def initialize(collection, entity, index = nil, size = 0)
        @collection = collection
        @entity     = entity
        @index      = index
        @size       = size
      end

      # @return [Vedeu::Editor::Line|Vedeu::Editor::Lines]
      def insert
        return collection.insert(index, entity) if index

        collection << entity
      end

      protected

      # @!attribute [r] collection
      # @return [Vedeu::Editor::Line|Vedeu::Editor::Lines]
      attr_reader :collection

      # @!attribute [r] entity
      # @return [String]
      attr_reader :entity

      # @!attribute [r] size
      # @return [Fixnum]
      attr_reader :size

      private

      # @return [Fixnum]
      def index
        return nil unless @index

        @index = 0    if @index < 0
        @index = size if @index > size
        @index
      end

    end # Insert

  end # Editor

end # Vedeu
