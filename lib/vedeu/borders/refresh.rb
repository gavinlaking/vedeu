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
                     :vertical

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

      # @example
      #   Vedeu.trigger(:_refresh_border_, name)
      #
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

      # @return [Array<Array<Vedeu::Views::Char>>]
      def by_name
        Vedeu.render_output(output) if enabled? && visible?
      end
      alias_method :render, :by_name

      protected

      # @!attribute [r] name
      # @return [String|Symbol]
      attr_reader :name

      private

      # Returns the border for the interface.
      #
      # @return (see Vedeu::Borders::Repository#by_name)
      def border
        @border ||= Vedeu.borders.by_name(name)
      end

      # @return [Array<Array<Vedeu::Views::Char>>]
      def output
        Vedeu.timer("Drawing border: '#{name}'".freeze) do
          out = [top, bottom]

          bordered_height.times { |y| out << [left(y), right(y)] }

          out.flatten
        end
      end

      # @param value [String]
      # @param type [Symbol|NilClass]
      # @param iy [Fixnum]
      # @param ix [Fixnum]
      # @return [Vedeu::Views::Char]
      def build(value, type = :border, iy = 0, ix = 0)
        Vedeu::Views::Char.new(value:    value,
                               parent:   interface,
                               colour:   colour,
                               name:     name,
                               style:    style,
                               position: [iy, ix],
                               border:   type)
      end

      # Creates the bottom left border character.
      #
      # @return [Vedeu::Views::Char]
      def build_bottom_left
        build(bottom_left, :bottom_left, yn, x) if left?
      end

      # Creates the bottom right border character.
      #
      # @return [Vedeu::Views::Char]
      def build_bottom_right
        build(bottom_right, :bottom_right, yn, xn) if right?
      end

      # Creates a top border character.
      #
      # @return [Array<Vedeu::Views::Char>]
      def build_top
        build_horizontal(:top_horizontal, y)
      end

      # Creates a bottom border character.
      #
      # @return [Array<Vedeu::Views::Char>]
      def build_bottom
        build_horizontal(:bottom_horizontal, yn)
      end

      # Creates the top left border character.
      #
      # @return [Vedeu::Views::Char]
      def build_top_left
        build(top_left, :top_left, y, x) if left?
      end

      # Creates the top right border character.
      #
      # @return [Vedeu::Views::Char]
      def build_top_right
        build(top_right, :top_right, y, xn) if right?
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
        return [] unless bottom?

        [build_bottom_left, captionbar, build_bottom_right].compact
      end

      # Returns the geometry for the interface.
      #
      # @return (see Vedeu::Geometries::Repository#by_name)
      def geometry
        Vedeu.geometries.by_name(name)
      end

      # @param position [Symbol] Either :top_horizontal, or
      #   :bottom_horizontal.
      # @param y_coordinate [Fixnum] The value of either y or yn.
      # @return [Array<Vedeu::Views::Char>]
      def build_horizontal(position, y_coordinate)
        Array.new(bordered_width) do |ix|
          build(horizontal, position, y_coordinate, (bx + ix))
        end
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
      alias_method :parent, :interface

      # Renders the left border for the interface.
      #
      # @param iy [Fixnum]
      # @return [String]
      def left(iy = 0)
        return [] unless left?

        build(vertical, :left_vertical, (by + iy), x)
      end

      # Renders the right border for the interface.
      #
      # @param iy [Fixnum]
      # @return [String]
      def right(iy = 0)
        return [] unless right?

        build(vertical, :right_vertical, (by + iy), xn)
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
        return [] unless top?

        [build_top_left, titlebar, build_top_right].compact
      end

      # An optional caption for when the bottom border is to be shown.
      #
      # @return [Array<Vedeu::Views::Char>]
      # @see [Vedeu::Borders::Caption#render]
      def captionbar
        return nil unless caption

        @_caption ||= Vedeu::Borders::Caption
                        .render(caption, width, build_bottom)
      end

      # An optional title for when the top border is to be shown.
      #
      # @return [Array<Vedeu::Views::Char>]
      # @see [Vedeu::Borders::Title#render]
      def titlebar
        return nil unless title

        @_title ||= Vedeu::Borders::Title.render(title, width, build_top)
      end

    end # Refresh

  end # Borders

end # Vedeu
