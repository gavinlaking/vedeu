# frozen_string_literal: true

module Vedeu

  module Output

    # During the conversion of a Vedeu::Cells::Char object into a
    # string of escape sequences, this class removes multiple
    # occurences of the same escape sequence, resulting in a smaller
    # payload being sent to the renderer.
    #
    # @api private
    #
    class Compressor

      include Vedeu::Common
      include Vedeu::Renderers::Options

      # @param (see #initialize)
      # @return (see #render)
      def self.render(output, options = {})
        new(output, options).render
      end

      # Returns a new instance of Vedeu::Output::Compressor.
      #
      # @param output [Vedeu::Models::Page]
      # @param options [Hash]
      # @option options compression [Boolean]
      # @return [Vedeu::Output::Compressor]
      def initialize(output, options = {})
        @output  = output
        @options = options
      end

      # @note
      #   - Takes approximately ~6ms for 2100 chars. (2015-11-25)
      #   - Takes approximately ~25ms for 2100 chars. (2015-07-25)
      # @return [String]
      # @return [Array<void>|String]
      def render
        return [] unless output?

        Vedeu::Output::CompressorCache.cache(content, compression?)
      end

      protected

      # @!attribute [r] output
      # @return [Array<Array<Vedeu::Cells::Char>>]
      attr_reader :output

      private

      # Returns the output with all of the empty cells removed to make
      # compression faster.
      #
      # @return [Array]
      def content
        Vedeu::Output::Compressors::Empty.with(output.content)
      end

      # @return [Boolean]
      def output?
        present?(output)
      end

    end # Compressor

  end # Output

end # Vedeu
