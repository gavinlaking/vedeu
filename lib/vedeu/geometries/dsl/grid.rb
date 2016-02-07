# frozen_string_literal: true

module Vedeu

  module Geometries

    # The grid system splits the terminal height and width into 12
    # equal parts, by dividing the available height and width by 12.
    # If the terminal height or width is not a multiple of 12, then
    # Grid chooses the maximum value which will fit.
    #
    # @api private
    #
    class Grid

      # @see #initialize
      # @see #columns
      def self.columns(value)
        new(value).columns
      end

      # @see #initialize
      # @see #rows
      def self.rows(value)
        new(value).rows
      end

      # Returns a new instance of Vedeu::Geometries::Grid.
      #
      # @param value [Fixnum]
      # @return [Vedeu::Geometries::Grid]
      def initialize(value)
        @value = value
      end

      # @macro raise_out_of_range
      # @see Vedeu::Geometries::DSL#columns
      def columns
        raise Vedeu::Error::OutOfRange if out_of_range?

        column * value
      end

      # @macro raise_out_of_range
      # @see Vedeu::Geometries::DSL#rows
      def rows
        raise Vedeu::Error::OutOfRange if out_of_range?

        row * value
      end

      protected

      # @!attribute [r] value
      # @return [Fixnum]
      attr_reader :value

      private

      # Returns the height of a single row in characters.
      #
      # @return [Fixnum]
      def row
        Vedeu.height / 12
      end

      # Returns a boolean indicating whether the value is out of
      # range.
      #
      # @return [Boolean]
      def out_of_range?
        value < 1 || value > 12
      end

      # Returns the width of a single column in characters.
      #
      # @return [Fixnum]
      def column
        Vedeu.width / 12
      end

    end # Grid

  end # Geometries

end # Vedeu
