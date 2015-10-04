module Vedeu

  module Editor

    # Crop the lines to the visible area of the document, as defined
    # by the geometry provided.
    #
    class Cropper

      extend Forwardable

      def_delegators :border,
                     :bx,
                     :bxn,
                     :by,
                     :byn,
                     :height,
                     :width

      # Returns a new instance of Vedeu::Editor::Cropper.
      #
      # @param lines [Vedeu::Editor::Lines]
      # @param name [String|Symbol]
      # @param ox [Fixnum]
      # @param oy [Fixnum]
      # @return [Vedeu::Editor::Cropper]
      def initialize(lines:, ox:, oy:, name:)
        @lines = lines
        @name  = name
        @ox    = ox
        @oy    = oy
      end

      # Returns the visible lines as a sequence of {Vedeu::View::Char}
      # objects.
      #
      # @return [Array<void>]
      def viewport
        out = []

        visible.each_with_index do |line, iy|
          line.chars.each_with_index do |char, ix|
            out << Vedeu::Views::Char.new(parent:   interface,
                                          position: [(by + iy), (bx + ix)],
                                          value:    char.freeze)
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
      # @return [String|Symbol]
      attr_reader :name

      # @!attribute [r] ox
      # @return [Fixnum]
      attr_reader :ox

      # @!attribute [r] oy
      # @return [Fixnum]
      attr_reader :oy

      private

      # Returns the visible lines.
      #
      # @note If there are no lines of content, we return an empty
      # array. If there are any empty lines, then they are discarded.
      #
      # @return [Array<void>]
      def visible
        lines.map { |line| columns(line) }
      end

      # Return a range of visible lines.
      #
      # @return [Vedeu::Editor::Lines]
      def lines
        @lines[oy...(oy + height)] || []
      end

      # @return [Vedeu::Models::Interface]
      def interface
        @interface ||= Vedeu.interfaces.by_name(name)
      end

      # Return a range of visible characters from each line.
      #
      # @return [String]
      def columns(line)
        line[ox...(ox + width)] || ''
      end

      # @return [Vedeu::Borders::Border]
      def border
        @border ||= Vedeu.borders.by_name(name)
      end

    end # Editor

  end # Cropper

end # Vedeu
