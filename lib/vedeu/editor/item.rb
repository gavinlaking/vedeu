# frozen_string_literal: true

module Vedeu

  module Editor

    # Fetches an item from a collection.
    #
    # @api private
    #
    class Item

      # @param (see #initialize)
      # @return (see #by_index)
      def self.by_index(collection, index = nil)
        new(collection, index).by_index
      end

      # Returns a new instance of Vedeu::Editor::Item.
      #
      # @param collection [Vedeu::Editor::Line|Vedeu::Editor::Lines]
      # @param index [Integer]
      # @return [Vedeu::Editor::item]
      def initialize(collection, index = nil)
        @collection = collection
        @index      = index
      end

      # @return [String|Vedeu::Editor::Line]
      def by_index
        return nil unless collection

        if index_out_of_range?
          last_item

        elsif index_within_range?
          nth_item

        else
          first_item

        end
      end

      protected

      # @!attribute [r] collection
      # @return [Vedeu::Editor::Line|Vedeu::Editor::Lines]
      attr_reader :collection

      # @!attribute [r] index
      # @return [Integer]
      attr_reader :index

      private

      # @return [String|Vedeu::Editor::Line]
      def first_item
        collection[0]
      end

      # @return [String|Vedeu::Editor::Line]
      def last_item
        collection[-1]
      end

      # @return [String|Vedeu::Editor::Line]
      def nth_item
        collection[index]
      end

      # @return [Boolean]
      def index_out_of_range?
        index.nil? || index > collection.size
      end

      # @return [Boolean]
      def index_within_range?
        index.positive? && index <= collection.size
      end

    end # Item

  end # Editor

end # Vedeu
