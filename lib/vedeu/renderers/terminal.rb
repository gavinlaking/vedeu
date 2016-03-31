# frozen_string_literal: true

module Vedeu

  module Renderers

    # Converts a grid of {Vedeu::Cells::Char} objects into a stream of
    # escape sequences and content suitable for a terminal.
    #
    # @api private
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
        Vedeu.direct_write(writable_data)
      end

      private

      # Returns the output in a compressed form if the :compression
      # option is true.
      #
      # @return [String]
      def content
        compression
      end

      # @return [String]
      def writable_data
        return write_file if write_file?

        content
      end

    end # Terminal

  end # Renderers

end # Vedeu
