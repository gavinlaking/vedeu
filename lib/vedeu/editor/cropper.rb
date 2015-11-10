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
        @name  = present?(name) ? name : Vedeu.focus
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

      # Returns the interface by name.
      #
      # @return (see Vedeu::Interfaces::Repository#by_name)
      def interface
        @interface ||= Vedeu.interfaces.by_name(name)
      end

      # Return a range of visible characters from each line.
      #
      # @return [String]
      def columns(line)
        line[ox...(ox + width)] || ''
      end

      # Returns the border for the interface.
      #
      # @return (see Vedeu::Borders::Repository#by_name)
      def border
        @border ||= Vedeu.borders.by_name(name)
      end

    end # Editor

  end # Cropper

end # Vedeu
