module Vedeu

  module Borders

    # Renders the provided border.
    #
    class Render

      extend Forwardable
      include Vedeu::Common

      def_delegators :border,
                     :bottom?,
                     :bottom_left,
                     :bottom_right,
                     :bx,
                     :bxn,
                     :by,
                     :byn,
                     :caption,
                     :colour,
                     :enabled?,
                     :height,
                     :horizontal,
                     :left?,
                     :name,
                     :right?,
                     :style,
                     :title,
                     :top?,
                     :top_left,
                     :top_right,
                     :width,
                     :vertical

      def_delegators :geometry,
                     :x,
                     :xn,
                     :y,
                     :yn

      # @return [Array<Array<Vedeu::Views::Char>>]
      # @param (see #initialize)
      def self.with(border)
        new(border).render
      end

      # Returns a new instance of Vedeu::Borders::Render.
      #
      # @param border [Vedeu::Borders::Border]
      # @return [Vedeu::Borders::Render]
      def initialize(border)
        @border = border
      end

      # @return [Array<Array<Vedeu::Views::Char>>]
      def render
        return [] unless enabled?

        Vedeu.timer("Bordering: '#{name}'") do
          out = [top, bottom]

          height.times { |y| out << [left(y), right(y)] }

          out.flatten
        end
      end

      protected

      # @!attribute [r] border
      # @return [Vedeu::Borders::Border]
      attr_reader :border

      private

      # @param value [String]
      # @param type [Symbol|NilClass]
      # @param iy [Fixnum]
      # @param ix [Fixnum]
      # @return [Vedeu::Views::Char]
      def build(value, type = :border, iy = 0, ix = 0)
        Vedeu::Views::Char.new(value:    value,
                               parent:   interface,
                               colour:   colour,
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
        build_horizontal(:bottom_horizontal, y)
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

      # @return [Vedeu::Geometry::Geometry]
      def geometry
        Vedeu.geometries.by_name(name)
      end

      # @param position [Symbol] Either :top_horizontal, or
      #   :bottom_horizontal.
      # @param y_coordinate [Fixnum] The value of either y or yn.
      # @return [Array<Vedeu::Views::Char>]
      def build_horizontal(position, y_coordinate)
        Array.new(width) do |ix|
          build(horizontal, position, y_coordinate, (bx + ix))
        end
      end

      # The parent of a border is always an interface.
      #
      # @return [Vedeu::Models::Interface]
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

      # Overwrite the border from {#build_horizontal} on the bottom
      # border to include the caption if given.
      #
      # @return [Array<Vedeu::Views::Char>]
      def captionbar
        return build_bottom unless caption? && caption_fits?

        caption_starts_at = (width - caption_characters.size) - 2

        caption_char = 0
        build_bottom.each_with_index do |char, index|
          next if index <= caption_starts_at || index > (width - 2)

          char.border  = nil
          char.value   = caption_characters[caption_char]
          caption_char += 1
        end
      end

      # Overwrite the border from {#build_horizontal} on the top
      # border to include the title if given.
      #
      # @return [Array<Vedeu::Views::Char>]
      def titlebar
        return build_top unless title? && title_fits?

        build_top.each_with_index do |char, index|
          next if index == 0 || index > title_characters.size

          char.border = nil
          char.value  = title_characters[(index - 1)]
        end
      end

      # Return boolean indicating whether this border has a non-empty
      # title.
      #
      # @return [Boolean]
      def title?
        present?(title)
      end

      # Return boolean indicating whether this border has a non-empty
      # caption.
      #
      # @return [Boolean]
      def caption?
        present?(caption)
      end

      # Return boolean indicating whether the title fits within the
      # width of the top border.
      #
      # @return [Boolean]
      def title_fits?
        width > title_characters.size
      end

      # Return boolean indicating whether the caption fits within the
      # width of the bottom border.
      #
      # @return [Boolean]
      def caption_fits?
        width > caption_characters.size
      end

      # @return [Array<String>]
      def title_characters
        @title_characters ||= title_padded.chars
      end

      # @return [Array<String>]
      def caption_characters
        @caption_characters ||= caption_padded.chars
      end

      # Pads the title with a single whitespace either side.
      #
      # @example
      #   title = 'Truncated!'
      #   width = 20
      #   # => ' Truncated! '
      #
      #   width = 10
      #   # => ' Trunca '
      #
      # @return [String]
      # @see #truncated_title
      def title_padded
        truncated_title.center(truncated_title.size + 2)
      end

      # Pads the caption with a single whitespace either side.
      #
      # @example
      #   caption = 'Truncated!'
      #   width = 20
      #   # => ' Truncated! '
      #
      #   width = 10
      #   # => ' Trunca '
      #
      # @return [String]
      # @see #truncated_caption
      def caption_padded
        truncated_caption.center(truncated_caption.size + 2)
      end

      # Truncates the title to the width of the interface, minus
      # characters needed to ensure there is at least a single
      # character of horizontal border and a whitespace on either side
      # of the title.
      #
      # @example
      #   title = 'Truncated!'
      #   width = 20
      #   # => 'Truncated!'
      #
      #   width = 10
      #   # => 'Trunca'
      #
      # @return [String]
      def truncated_title
        title.chomp.slice(0..(width - 5))
      end

      # Truncates the caption to the width of the interface, minus
      # characters needed to ensure there is at least a single
      # character of horizontal border and a whitespace on either
      # side of the caption.
      #
      # @example
      #   caption = 'Truncated!'
      #   width = 20
      #   # => 'Truncated!'
      #
      #   width = 10
      #   # => 'Trunca'
      #
      # @return [String]
      def truncated_caption
        caption.chomp.slice(0..(width - 5))
      end

    end # Render

  end # Borders

end # Vedeu
