module Vedeu

  module Models

    # A Row represents an array of Vedeu::Cells::Empty objects.
    #
    class Row

      include Enumerable

      # @!attribute [r] cells
      # @return [Array<NilClass|void>]
      attr_reader :cells

      # @param value [Vedeu::Models::Row|Array<void>|void]
      # @return [Vedeu::Models::Row]
      def self.coerce(value)
        if value.is_a?(self)
          value

        elsif value.is_a?(Array)
          new(value.compact)

        elsif value.nil?
          new

        else
          new([value])

        end
      end

      # Returns a new instance of Vedeu::Models::Row.
      #
      # @param cells [Array<NilClass|void>]
      # @return [Vedeu::Models::Row]
      def initialize(cells = [])
        @cells = cells || []
      end

      # @param index [Fixnum]
      # @return [NilClass|void]
      def cell(index)
        return nil if index.nil?

        cells[index]
      end

      # @return [Array<void>]
      def content
        (cells.flatten << reset_character).reject(&:cell?)
      end

      # Provides iteration over the collection.
      #
      # @param block [Proc]
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
        self.class == other.class && cells == other.cells
      end
      alias_method :==, :eql?

      # Provides the reset escape sequence at the end of a row to
      # reset colour and style information to prevent colour bleed on
      # the next line.
      #
      # @return [Vedeu::Views::Char]
      def reset_character
        Vedeu::Views::Char.new(value: Vedeu::EscapeSequences::Esc.reset)
      end

      # @return [Fixnum]
      def size
        cells.size
      end

    end # Row

  end # Models

end # Vedeu
