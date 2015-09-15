module Vedeu

  module Editor

    # Manipulate the lines of an Vedeu::Editor::Document.
    #
    class Insert

      # @return [Vedeu::Editor::Line|Vedeu::Editor::Lines]
      # @see #initialize
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
        if index
          if index <= 0
            collection.insert(0, entity)

          elsif index >= size
            collection << entity

          else
            collection.insert(index, entity)

          end
        else
          collection << entity

        end
      end

      protected

      # @!attribute [r] collection
      # @return [Vedeu::Editor::Line|Vedeu::Editor::Lines]
      attr_reader :collection

      # @!attribute [r] entity
      # @return [String]
      attr_reader :entity

      # @!attribute [r] index
      # @return [Fixnum]
      attr_reader :index

      # @!attribute [r] size
      # @return [Fixnum]
      attr_reader :size

    end # Insert

  end # Editor

end # Vedeu
