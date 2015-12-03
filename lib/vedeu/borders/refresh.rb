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

      # @return [Array<Array<Vedeu::Views::Char>>]
      def output
        Vedeu.timer("Drawing border: '#{name}'".freeze) do
          [top, left, right, bottom].flatten
        end
      end

      # Creates the bottom left border character.
      #
      # @return [NilClass|Vedeu::Cells::Border|Vedeu::Views::Char]
      def build_bottom_left
        return nil unless left?
        return bottom_left if bottom_left

        Vedeu::Cells::BottomLeft.new(attributes)
      end

      # Creates the bottom right border character.
      #
      # @return [NilClass|Vedeu::Cells::Border|Vedeu::Views::Char]
      def build_bottom_right
        return nil unless right?
        return bottom_right if bottom_right

        Vedeu::Cells::BottomRight.new(attributes)
      end

      # Creates the top left border character.
      #
      # @return [NilClass|Vedeu::Cells::Border|Vedeu::Views::Char]
      def build_top_left
        return nil unless left?
        return top_left if top_left

        Vedeu::Cells::TopLeft.new(attributes)
      end

      # Creates the top right border character.
      #
      # @return [NilClass|Vedeu::Cells::Border|Vedeu::Views::Char]
      def build_top_right
        return nil unless right?
        return top_right if top_right

        Vedeu::Cells::TopRight.new(attributes)
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
      # @return [Array<void>]
      def left
        return [] unless left?

        build_collection(bordered_height) do |iy|
          cell = left_vertical_cell.dup
          cell.position = [by + iy, x]
          cell
        end
      end

      # Renders the right border for the interface.
      #
      # @return [Array<void>]
      def right
        return [] unless right?

        build_collection(bordered_height) do |iy|
          cell = right_vertical_cell.dup
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
        return [] unless top?

        [build_top_left, titlebar, build_top_right].compact
      end

      # An optional caption for when the bottom border is to be shown.
      #
      # @return [Array<Vedeu::Views::Char>]
      # @see [Vedeu::Borders::Caption#render]
      def captionbar
        return build_bottom unless present?(caption)

        Vedeu::Borders::Caption.render(name, caption, build_bottom)
      end

      # Creates a bottom border character.
      #
      # @return [Array<Vedeu::Views::Char>]
      def build_bottom
        build_collection(bordered_width) do |ix|
          cell = bottom_horizontal_cell.dup
          cell.position = [yn, bx + ix]
          cell
        end
      end

      # An optional title for when the top border is to be shown.
      #
      # @return [Array<Vedeu::Views::Char>]
      # @see [Vedeu::Borders::Title#render]
      def titlebar
        return build_top unless present?(title)

        Vedeu::Borders::Title.render(name, title, build_top)
      end

      # Creates a top border character.
      #
      # @return [Array<Vedeu::Views::Char>]
      def build_top
        build_collection(bordered_width) do |ix|
          cell = top_horizontal_cell.dup
          cell.position = [y, bx + ix]
          cell
        end
      end

      # Return the client application configured left vertical cell
      # character, or the default if not set.
      #
      # @return [Vedeu::Cells::LeftVertical]
      def left_vertical_cell
        return left_vertical if left_vertical

        Vedeu::Cells::LeftVertical.new(attributes)
      end

      # Return the client application configured right vertical cell
      # character, or the default if not set.
      #
      # @return [Vedeu::Cells::RightVertical]
      def right_vertical_cell
        return right_vertical if right_vertical

        Vedeu::Cells::RightVertical.new(attributes)
      end

      # Return the client application configured top horizontal cell
      # character, or the default if not set.
      #
      # @return [Vedeu::Cells::TopHorizontal]
      def top_horizontal_cell
        return top_horizontal if top_horizontal

        Vedeu::Cells::TopHorizontal.new(attributes)
      end

      # Return the client application configured bottom horizontal
      # cell character, or the default if not set.
      #
      # @return [Vedeu::Cells::BottomHorizontal]
      def bottom_horizontal_cell
        return bottom_horizontal if bottom_horizontal

        Vedeu::Cells::BottomHorizontal.new(attributes)
      end

      # Build a collection with the given size of objects given within
      # the block.
      #
      # @param size [Fixnum]
      # @return [Array<void>]
      def build_collection(size)
        Array.new(size) { |e| yield(e) }
      end

    end # Refresh

  end # Borders

end # Vedeu
