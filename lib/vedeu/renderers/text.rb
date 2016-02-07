# frozen_string_literal: true

module Vedeu

  module Renderers

    # Converts a grid of {Vedeu::Cells} objects or
    # {Vedeu::Cells::Char} objects into a stream of characters without
    # escape sequences.
    #
    class Text < Vedeu::Renderers::File

      include Vedeu::Renderers::Options

      private

      # Combine all characters in a row to produce a line, then all
      # lines should be terminated with `\n`. Convert to an array of
      # UTF8 codepoints, and any codepoint above 255 should be
      # converted to a space.
      #
      # @return [String]
      def content
        return '' if string?(output) || absent?(output)

        buffer.map(&:join).join("\n").unpack('U*').map do |c|
          (c > 255) ? ' ' : c.chr
        end.join
      end

      # @return [Array<String>]
      def buffer
        empty = Array.new(Vedeu.height) { Array.new(Vedeu.width) { ' ' } }

        output.each do |row|
          row.each do |char|
            next unless renderable?(char) &&
                        positionable?(char) &&
                        textual?(char)

            empty[char.position.y - 1][char.position.x - 1] = char.text
          end
        end

        empty
      end

      # @return [Array<Class>]
      def renderables
        [
          Vedeu::Cells::Border,
          Vedeu::Cells::BottomHorizontal,
          Vedeu::Cells::BottomLeft,
          Vedeu::Cells::BottomRight,
          Vedeu::Cells::Corner,
          Vedeu::Cells::Char,
          Vedeu::Cells::Clear,
          Vedeu::Cells::Empty,
          Vedeu::Cells::Horizontal,
          Vedeu::Cells::LeftVertical,
          Vedeu::Cells::RightVertical,
          Vedeu::Cells::TopHorizontal,
          Vedeu::Cells::TopLeft,
          Vedeu::Cells::TopRight,
          Vedeu::Cells::Vertical,
        ]
      end

      # @return [Boolean]
      def renderable?(char)
        renderables.include?(char.class)
      end

      # @return [Boolean]
      def textual?(char)
        char.respond_to?(:text)
      end

    end # Text

  end # Renderers

end # Vedeu
