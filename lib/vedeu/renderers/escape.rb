# frozen_string_literal: true

module Vedeu

  module Renderers

    # Converts a grid of {Vedeu::Cells} objects or
    # {Vedeu::Cells::Char} objects into a stream of characters without
    # escape sequences.
    #
    # @api private
    #
    class Escape < Vedeu::Renderers::File

      include Vedeu::Renderers::Options

      # Render a cleared output.
      #
      # @return [String]
      def clear
        render('[[:clear]]')
      end

      private

      # Combine all characters in a row to produce a line, then all
      # lines should be terminated with `\n`. Convert to an array of
      # UTF8 codepoints, and any codepoint above 255 should be
      # converted to a space.
      #
      # @return [String]
      def content
        return '[[:empty]]' if string?(output) || absent?(output)

        buffer.map { |row| row.join("\n") }.join("\n\n")
      end

      # @return [Array<String>]
      def buffer
        empty = Array.new(Vedeu.height) { Array.new(Vedeu.width) { '[:cell]' } }

        output.each do |row|
          row.each do |char|
            next unless positionable?(char)

            empty[char.position.y - 1][char.position.x - 1] = char.to_ast
          end
        end

        empty
      end

    end # Escape

  end # Renderers

end # Vedeu
