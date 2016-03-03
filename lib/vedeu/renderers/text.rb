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
            next unless positionable?(char)

            empty[char.position.y - 1][char.position.x - 1] = char.text
          end
        end

        empty
      end

    end # Text

  end # Renderers

end # Vedeu
