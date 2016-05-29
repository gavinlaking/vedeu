# frozen_string_literal: true

module Vedeu

  module Borders

    # Renders and refreshes the named border.
    #
    # @api private
    #
    class Refresh

      extend Forwardable
      include Vedeu::Common

      def_delegators :border,
                     :bottom?,
                     :bottom_left,
                     :bottom_right,
                     :bottom_horizontal,
                     :caption,
                     :colour,
                     :enabled?,
                     :horizontal,
                     :left?,
                     :right?,
                     :style,
                     :title,
                     :top?,
                     :top_left,
                     :top_right,
                     :top_horizontal,
                     :vertical,
                     :left_vertical,
                     :right_vertical

      def_delegators :geometry,
                     :bordered_height,
                     :bordered_width,
                     :bx,
                     :bxn,
                     :by,
                     :byn,
                     :height,
                     :width,
                     :x,
                     :xn,
                     :y,
                     :yn

      def_delegators :interface,
                     :visible?

      # {include:file:docs/events/by_name/refresh_border.md}
      # @param (see #initialize)
      # @return (see #by_name)
      def self.by_name(name = Vedeu.focus)
        name || Vedeu.focus

        new(name).by_name
      end

      # Returns a new instance of Vedeu::Borders::Refresh.
      #
      # @macro param_name
      # @return [Vedeu::Borders::Refresh]
      def initialize(name = Vedeu.focus)
        @name = present?(name) ? name : Vedeu.focus
      end

      # @return [Array<Array<Vedeu::Cells::Char>>]
      def by_name
        Vedeu.render_output(output) if enabled? && visible?
      end
      alias render by_name

      protected

      # @!attribute [r] name
      # @macro return_name
      attr_reader :name

      private

      # @return [Hash<Symbol => void>]
      def attributes
        {
          colour: colour,
          name:   name,
          style:  style,
        }
      end

      # @macro border_by_name
      def border
        @border ||= Vedeu.borders.by_name(name)
      end

      # @return [Array<Array<Vedeu::Cells::Char>>]
      def output
        Vedeu.timer("Drawing border: '#{name}'") do
          [
            (top if top?),
            (left if left?),
            (right if right?),
            (bottom if bottom?),
          ].flatten
        end
      end

      # Renders the bottom border for the interface.
      #
      # @note
      #   If a caption has been specified, then the bottom border will
      #   include this caption unless the size of the interface is
      #   smaller than the padded caption length.
      #
      # @return [String]
      def bottom
        [(bottom_left if left?), captionbar, (bottom_right if right?)].compact
      end

      # @return [Array<void>]
      def bottom_border
        build_collection(bordered_width) do |ix|
          bottom_horizontal.dup.tap { |cell| cell.position = [yn, bx + ix] }
        end
      end

      # @macro geometry_by_name
      def geometry
        Vedeu.geometries.by_name(name)
      end

      # Returns the interface by name.
      #
      # @note
      #   The parent of a border is always an interface.
      #
      # @macro interface_by_name
      def interface
        @_interface ||= Vedeu.interfaces.by_name(name)
      end
      alias parent interface

      # Renders the left border for the interface.
      #
      # @return [Array<void>]
      def left
        build_collection(bordered_height) do |iy|
          left_vertical.dup.tap { |cell| cell.position = [by + iy, x] }
        end
      end

      # Renders the right border for the interface.
      #
      # @return [Array<void>]
      def right
        build_collection(bordered_height) do |iy|
          right_vertical.dup.tap { |cell| cell.position = [by + iy, xn] }
        end
      end

      # Renders the top border for the interface.
      #
      # @note
      #   If a title has been specified, then the top border will
      #   include this title unless the size of the interface is
      #   smaller than the padded title length.
      #
      # @return [String]
      def top
        [(top_left if left?), titlebar, (top_right if right?)].compact
      end

      # @return [Array<void>]
      def top_border
        build_collection(bordered_width) do |ix|
          top_horizontal.dup.tap { |cell| cell.position = [y, bx + ix] }
        end
      end

      # An optional caption for when the bottom border is to be shown.
      #
      # @return (see Vedeu::Borders::Caption#render)
      def captionbar
        return bottom_border unless present?(caption)

        Vedeu::Borders::Caption.render(name, caption, bottom_border)
      end

      # An optional title for when the top border is to be shown.
      #
      # @return (see Vedeu::Borders::Title#render)
      def titlebar
        return top_border unless present?(title)

        Vedeu::Borders::Title.render(name, title, top_border)
      end

      # Build a collection with the given size of objects given within
      # the block.
      #
      # @param size [Fixnum]
      # @macro param_block
      # @return [Array<void>]
      def build_collection(size, &block)
        Array.new(size) { |e| yield(e) }
      end

    end # Refresh

  end # Borders

end # Vedeu
