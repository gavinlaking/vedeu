# frozen_string_literal: true

module Vedeu

  module Models

    # A Page represents an array of Vedeu::Models::Row objects.
    #
    # @api private
    #
    class Page

      include Enumerable

      # @!attribute [r] rows
      # @return [Array<NilClass|Vedeu::Models::Row>]
      attr_reader :rows

      class << self

        extend Forwardable

        def_delegators Vedeu::Coercers::Page,
                       :coerce

      end # Eigenclass

      # Returns a new instance of Vedeu::Models::Page.
      #
      # @param rows [Array<NilClass|Vedeu::Models::Row>]
      # @return [Vedeu::Models::Page]
      def initialize(rows = [])
        @rows = rows || []
      end

      # @return [Array<void>]
      def content
        rows.flat_map(&:content)
      end

      # @param row_index [Integer]
      # @param cell_index [Integer]
      # @return [NilClass|void]
      def cell(row_index = nil, cell_index = nil)
        return nil if row_index.nil? || cell_index.nil?
        return nil unless row(row_index)

        row(row_index)[cell_index]
      end

      # Provides iteration over the collection.
      #
      # @macro param_block
      # @return [Enumerator]
      def each(&block)
        rows.each(&block)
      end

      # @return [Boolean]
      def empty?
        rows.empty?
      end

      # An object is equal when its values are the same.
      #
      # @param other [Vedeu::Models::Page]
      # @return [Boolean]
      def eql?(other)
        self.class.equal?(other.class) && rows == other.rows
      end
      alias == eql?

      # @param index [Integer]
      # @return [NilClass|Vedeu::Models::Row]
      def row(index = nil)
        return nil if index.nil?

        rows[index]
      end

      # @return [Integer]
      def size
        rows.size
      end

    end # Page

  end # Models

end # Vedeu
