# frozen_string_literal: true

module Vedeu

  module Models

    # A Row represents an array of Vedeu::Cells::Empty objects.
    #
    # @api private
    #
    class Row

      include Enumerable
      include Vedeu::Common

      # @!attribute [r] cells
      # @return [Array<NilClass|void>]
      attr_reader :cells

      class << self

        extend Forwardable

        def_delegators Vedeu::Coercers::Row,
                       :coerce

      end # Eigenclass

      # Returns a new instance of Vedeu::Models::Row.
      #
      # @param cells [Array<NilClass|void>]
      # @return [Vedeu::Models::Row]
      def initialize(cells = [])
        @cells = cells || []
      end

      # @param index [Integer]
      # @return [NilClass|void]
      def cell(index)
        return nil if index.nil? || empty?

        cells[index]
      end

      # @return [Array<void>]
      def content
        (cells.flatten << reset_character)
      end

      # Provides iteration over the collection.
      #
      # @macro param_block
      # @return [Enumerator]
      def each(&block)
        cells.each(&block)
      end

      # @return [Boolean]
      def empty?
        cells.empty?
      end

      # An object is equal when its values are the same.
      #
      # @param other [Vedeu::Models::Row]
      # @return [Boolean]
      def eql?(other)
        self.class.equal?(other.class) && cells == other.cells
      end
      alias == eql?

      # Provides the reset escape sequence at the end of a row to
      # reset colour and style information to prevent colour bleed on
      # the next line.
      #
      # @return [Vedeu::Cells::Escape]
      def reset_character
        Vedeu::Cells::Escape.new(value: Vedeu.esc.reset)
      end

      # @return [Integer]
      def size
        cells.size
      end

    end # Row

  end # Models

end # Vedeu
