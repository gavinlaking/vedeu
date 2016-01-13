# frozen_string_literal: true

module Vedeu

  module Renderers

    # Converts a grid of {Vedeu::Cells::Char} objects into a stream of
    # escape sequences and content suitable for a terminal.
    #
    class Terminal

      include Vedeu::Renderers::Options

      # Render a cleared output.
      #
      # @return [String]
      def clear
        Vedeu::Terminal.clear

        render('')
      end

      # Render the output (either content or clearing) to the console.
      #
      # @return [String]
      def write
        if write_file?
          Vedeu::Terminal.output(write_file)

        else
          Vedeu::Terminal.output(content)

        end
      end

      private

      # Returns the output in a compressed form if the :compression
      # option is true.
      #
      # @return [String]
      def content
        compression
      end

    end # Terminal

  end # Renderers

end # Vedeu
