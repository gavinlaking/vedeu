# frozen_string_literal: true

module Vedeu

  module Output

    # A Viewport is the visible part of the content within an
    # interface.
    #
    # When a buffer has more lines than the defined height, or more
    # columns than the defined width of the interface, this class
    # provides 'scrolling' via the cursor's position.
    #
    # @api private
    #
    class Viewport

      extend Forwardable

      def_delegators :view,
                     :lines,
                     :name,
                     :visible?

      def_delegators :geometry,
                     :bordered_height,
                     :bordered_width,
                     :bx,
                     :by

      def_delegators :cursor,
                     :ox,
                     :oy

      # @param (see #initialize)
      # @return (see #render)
      def self.render(view)
        new(view).render if view
      end

      # Returns a new instance of Vedeu::Output::Viewport.
      #
      # @param view [Vedeu::Views::View]
      # @return [Vedeu::Output::Viewport]
      def initialize(view)
        @view = view
      end

      # Returns the content for the view.
      #
      # @return [Array<Array<String>>|NilClass]
      def render
        Vedeu.render_output(output) if visible?
      end

      # Returns a string representation of the viewport.
      #
      # @return [String]
      def to_s
        Array(render).map(&:to_s).join("\n")
      end
      alias to_str to_s

      protected

      # @!attribute [r] view
      # @return [Vedeu::Views::View]
      attr_reader :view

      private

      # Using the current cursor's x position, return a range of
      # visible columns.
      #
      # Scrolls the content horizontally when the stored cursor's x
      # position for the interface is outside of the visible area.
      #
      # @note
      #   The width is reduced by one as #columns is a range of Array
      #   elements.
      #
      # @return [Range]
      def columns
        left...(left + bordered_width)
      end

      # Returns the offset for the content (the number of rows or
      # columns to change the viewport by on either the y or x axis)
      # determined by the offset (the cursor's y or x offset position.
      #
      # @param offset [Fixnum] The cursor's oy or ox values.
      # @param dimension [Fixnum] Either the height or width.
      # @return [Fixnum]
      def content_offset(offset, dimension)
        return 0 unless offset >= dimension

        offset - dimension
      end

      # @macro cursor_by_name
      def cursor
        Vedeu.cursors.by_name(name)
      end

      # @macro geometry_by_name
      def geometry
        Vedeu.geometries.by_name(name)
      end

      # @return [Fixnum]
      def left
        content_offset(ox, bordered_width)
      end

      # @return [Array<Array<Vedeu::Cells::Char>>]
      def output
        Vedeu.timer("Rendering content: '#{name}'") do
          out = []

          show.each_with_index do |line, iy|
            line.each_with_index do |column, ix|
              column.position = [by + iy, bx + ix]
              out << column
            end
          end

          out
        end
      end

      # Using the current cursor's y position, return a range of
      # visible lines.
      #
      # Scrolls the content vertically when the stored cursor's y
      # position for the interface is outside of the visible area.
      #
      # @note
      #   The height is reduced by one as #rows is a range of Array
      #   elements.
      #
      # @return [Range]
      def rows
        top...(top + bordered_height)
      end

      # Returns the visible content for the view.
      #
      # @note If there are no lines of content, we return an empty
      #   array. If there are no more columns of content we return a
      #   space enclosed in an array; this prevents a weird line
      #   hopping bug which occurs when the current line has no more
      #   content, but subsequent lines do.
      #
      # @return [Array]
      def show
        (lines[rows] || []).map { |line| (line.chars[columns] || []) }
      end

      # @return [Fixnum]
      def top
        content_offset(oy, bordered_height)
      end

    end # Viewport

  end # Output

end # Vedeu
