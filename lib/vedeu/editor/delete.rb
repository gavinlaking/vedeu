# frozen_string_literal: true

module Vedeu

  module Editor

    # Manipulate the lines of an Vedeu::Editor::Document.
    #
    # @api private
    #
    class Delete

      include Vedeu::Common

      # @param (see #initialize)
      # @return [Vedeu::Editor::Line|Vedeu::Editor::Lines]
      def self.from(collection, index = nil, size = 0)
        new(collection, index, size).delete
      end

      # Returns a new instance of Vedeu::Editor::Delete.
      #
      # @param collection [Vedeu::Editor::Line|Vedeu::Editor::Lines]
      # @param index [Integer]
      # @param size [Integer]
      # @return [Vedeu::Editor::Delete]
      def initialize(collection, index = nil, size = 0)
        @collection = collection
        @index      = index
        @size       = size
      end

      # @return [Vedeu::Editor::Line|Vedeu::Editor::Lines]
      def delete
        return collection if collection.empty? || negative_index?
        return collection.dup.tap { |c| c.slice!(index) } if index
        return collection.dup.tap(&:pop) if lines?
        return collection.chop if line?
      end

      protected

      # @!attribute [r] collection
      # @return [Vedeu::Editor::Line|Vedeu::Editor::Lines]
      attr_reader :collection

      # @!attribute [r] size
      # @return [Integer]
      attr_reader :size

      private

      # @return [Integer]
      def index
        return nil unless @index

        @index = size - 1 if @index > size
        @index
      end

      # If true, we are dealing with a {Vedeu::Editor::Line} object.
      #
      # @return [Boolean]
      def line?
        string?(collection)
      end

      # If true, we are dealing with a {Vedeu::Editor::Lines}
      # collection.
      #
      # @return [Boolean]
      def lines?
        array?(collection)
      end

      # Returns a boolean indicating whether the index was given or
      # negative.
      #
      # @return [Boolean]
      def negative_index?
        index && index < 0
      end

    end # Delete

  end # Editor

end # Vedeu
