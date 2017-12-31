# frozen_string_literal: true

module Vedeu

  module Editor

    # Crop the lines to the visible area of the document, as defined
    # by the geometry provided.
    #
    # @api private
    #
    class Cropper

      extend Forwardable
      include Vedeu::Common

      def_delegators :geometry,
                     :bordered_height,
                     :bordered_width,
                     :bx,
                     :bxn,
                     :by,
                     :byn

      # Returns a new instance of Vedeu::Editor::Cropper.
      #
      # @param lines [Vedeu::Editor::Lines]
      # @macro param_name
      # @param ox [Integer]
      # @param oy [Integer]
      # @return [Vedeu::Editor::Cropper]
      def initialize(lines:, ox:, oy:, name:)
        @lines = lines
        @name  = present?(name) ? name : Vedeu.focus
        @ox    = ox
        @oy    = oy
      end

      # Returns the visible lines as a sequence of {Vedeu::Cells::Char}
      # objects.
      #
      # @return [Array<void>]
      def viewport
        out = []

        visible.each_with_index do |line, iy|
          line.chars.each_with_index do |char, ix|
            out << Vedeu::Cells::Char.new(
              name:     name,
              position: Vedeu::Geometries::Position.new((by + iy), (bx + ix)),
              value:    char
            )
          end
        end

        out
      end

      # @return [Array<void>]
      def to_a
        visible
      end

      protected

      # @!attribute [r] name
      # @macro return_name
      attr_reader :name

      # @!attribute [r] ox
      # @return [Integer]
      attr_reader :ox

      # @!attribute [r] oy
      # @return [Integer]
      attr_reader :oy

      private

      # Returns the visible lines and their respective content,
      # determined by the offsets 'ox' and 'oy'.
      #
      # @note If there are no lines of content, we return an empty
      # array. If there are any empty lines, then they are discarded.
      #
      # @return [Array<void>]
      def visible
        lines.map { |line| line[ox...(ox + bordered_width)] || '' }
      end

      # Return a range of visible lines.
      #
      # @return [Vedeu::Editor::Lines]
      def lines
        @lines[oy...(oy + bordered_height)] || []
      end

      # @macro geometry_by_name
      def geometry
        @_geometry ||= Vedeu.geometries.by_name(name)
      end

    end # Editor

  end # Cropper

end # Vedeu
