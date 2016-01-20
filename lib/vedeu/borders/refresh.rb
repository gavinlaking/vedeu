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
      # @param name [String|Symbol] The name of the interface/view
      #   border to be refreshed. Defaults to `Vedeu.focus`.
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
      # @return [String|Symbol]
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

      # Returns the border for the interface.
      #
      # @return (see Vedeu::Borders::Repository#by_name)
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

      # Returns the geometry for the interface.
      #
      # @return (see Vedeu::Geometries::Repository#by_name)
      def geometry
        Vedeu.geometries.by_name(name)
      end

      # Returns the interface by name.
      #
      # @note
      #   The parent of a border is always an interface.
      #
      # @return (see Vedeu::Interfaces::Repository#by_name)
      def interface
        @interface ||= Vedeu.interfaces.by_name(name)
      end
      alias parent interface

      # Renders the left border for the interface.
      #
      # @return [Array<void>]
      def left
        build_collection(bordered_height) do |iy|
          cell = left_vertical.dup
          cell.position = [by + iy, x]
          cell
        end
      end

      # Renders the right border for the interface.
      #
      # @return [Array<void>]
      def right
        build_collection(bordered_height) do |iy|
          cell = right_vertical.dup
          cell.position = [by + iy, xn]
          cell
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

      # An optional caption for when the bottom border is to be shown.
      #
      # @return (see Vedeu::Borders::Caption#render)
      def captionbar
        characters = build_collection(bordered_width) do |ix|
          cell = bottom_horizontal.dup
          cell.position = [yn, bx + ix]
          cell
        end

        return characters unless present?(caption)

        Vedeu::Borders::Caption.render(name, caption, characters)
      end

      # An optional title for when the top border is to be shown.
      #
      # @return (see Vedeu::Borders::Title#render)
      def titlebar
        characters = build_collection(bordered_width) do |ix|
          cell = top_horizontal.dup
          cell.position = [y, bx + ix]
          cell
        end

        return characters unless present?(title)

        Vedeu::Borders::Title.render(name, title, characters)
      end

      # Build a collection with the given size of objects given within
      # the block.
      #
      # @param size [Fixnum]
      # @param block [Proc]
      # @return [Array<void>]
      def build_collection(size, &block)
        Array.new(size) { |e| yield(e) }
      end

    end # Refresh

  end # Borders

  # :nocov:

  # {include:file:docs/events/by_name/refresh_border.md}
  Vedeu.bind(:_refresh_border_) do |name|
    Vedeu::Borders::Refresh.by_name(name) if Vedeu.ready?
  end

  # :nocov:

end # Vedeu
