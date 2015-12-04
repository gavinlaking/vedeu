module Vedeu

  module Renderers

    # Converts a grid of {Vedeu::Cells} objects or
    # {Vedeu::Views::Char} objects into a stream of characters without
    # escape sequences.
    #
    class Text < Vedeu::Renderers::File

      include Vedeu::Common
      include Vedeu::Renderers::Options

      # Returns a new instance of Vedeu::Renderers::Text.
      #
      # @param options [Hash]
      # @return [Vedeu::Renderers::Text]
      def initialize(options = {})
        @options = options || {}
      end

      # Render a cleared output.
      #
      # @return [String]
      def clear
        ''
      end

      # @param output [Vedeu::Models::Page]
      # @return [Array<String>]
      def render(output)
        return '' unless present?(output)

        output.each do |row|
          row.each do |char|
            next unless renderable?(char) &&
                        positionable?(char) &&
                        textual?(char)

            # fail char.inspect

            buffer[char.position.y - 1][char.position.x - 1] = char.text
          end
        end

        ::File.write(filename, data) if write_file?

        data
      end

      private

      # @return [Array<String>]
      def buffer
        @buffer ||= Array.new(Vedeu.height) { Array.new(Vedeu.width) { ' ' } }
      end

      # @return [String]
      def data
        @data ||= buffer.map(&:join).join("\n").unpack('U*').map do |c|
          (c > 255) ? ' ' : c.chr
        end.join
      end

      # @return [Boolean]
      def positionable?(char)
        char.respond_to?(:position) &&
        char.position.is_a?(Vedeu::Geometries::Position)
      end

      # @return [Array<Class>]
      def renderables
        [
          Vedeu::Cells::Empty,
          Vedeu::Cells::TopLeft,
          Vedeu::Cells::TopHorizontal,
          Vedeu::Cells::Char,
          Vedeu::Cells::TopRight,
          Vedeu::Views::Char,
          Vedeu::Cells::Clear,
          Vedeu::Cells::LeftVertical,
          Vedeu::Cells::RightVertical,
          Vedeu::Cells::BottomLeft,
          Vedeu::Cells::BottomHorizontal,
          Vedeu::Cells::BottomRight,
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
