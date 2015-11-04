module Vedeu

  module Editor

    # Manipulate the lines of an Vedeu::Editor::Document.
    #
    class Delete

      # @param (see #initialize)
      # @return [Vedeu::Editor::Line|Vedeu::Editor::Lines]
      def self.from(collection, index = nil, size = 0)
        new(collection, index, size).delete
      end

      # Returns a new instance of Vedeu::Editor::Delete.
      #
      # @param collection [Vedeu::Editor::Line|Vedeu::Editor::Lines]
      # @param index [Fixnum]
      # @param size [Fixnum]
      # @return [Vedeu::Editor::Delete]
      def initialize(collection, index = nil, size = 0)
        @collection = collection
        @index      = index
        @size       = size
      end

      # @return [Vedeu::Editor::Line|Vedeu::Editor::Lines]
      def delete
        return collection if collection.empty? || (index && index < 0)
        return collection.dup.tap { |c| c.slice!(index) } if index

        if collection.is_a?(Array)
          collection.dup.tap(&:pop)

        elsif collection.is_a?(String)
          collection.chop

        end
      end

      protected

      # @!attribute [r] collection
      # @return [Vedeu::Editor::Line|Vedeu::Editor::Lines]
      attr_reader :collection

      # @!attribute [r] size
      # @return [Fixnum]
      attr_reader :size

      private

      # @return [Fixnum]
      def index
        return nil unless @index

        @index = size - 1 if @index > size
        @index
      end

    end # Delete

  end # Editor

end # Vedeu
