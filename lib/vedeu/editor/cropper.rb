module Vedeu

  module Editor

    # Crop the lines to the visible area of the document, as defined
    # by the geometry provided.
    #
    class Cropper

      # Returns a new instance of Vedeu::Editor::Cropper.
      #
      # @param lines [Vedeu::Editor::Lines]
      # @param height [Fixnum]
      # @param width [Fixnum]
      # @param ox [Fixnum]
      # @param oy [Fixnum]
      # @return [Vedeu::Editor::Cropper]
      def initialize(lines:, height:, width:, ox:, oy:)
        @lines  = lines
        @height = height
        @width  = width
        @ox     = ox
        @oy     = oy
      end

      # Returns the lines cropped.
      #
      # @note If there are no lines of content, we return an empty
      # array. If there are any empty lines, then they are discarded.
      #
      # @return [Array<void>]
      def cropped
        lines.map { |line| columns(line) }
      end

      protected

      # @!attribute [r] height
      # @return [Fixnum]
      attr_reader :height

      # @!attribute [r] width
      # @return [Fixnum]
      attr_reader :width

      # @!attribute [r] ox
      # @return [Fixnum]
      attr_reader :ox

      # @!attribute [r] oy
      # @return [Fixnum]
      attr_reader :oy

      private

      # Return a range of visible lines.
      #
      # @return [Vedeu::Editor::Lines]
      def lines
        @lines[oy...(oy + height)] || []
      end

      # Return a range of visible characters from each line.
      #
      # @return [String]
      def columns(line)
        line[ox...(ox + width)] || ''
      end

    end # Editor

  end # Cropper

end # Vedeu
