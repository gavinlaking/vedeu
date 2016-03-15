# frozen_string_literal: true

module Vedeu

  module Output

    module Compressors

      # A simple compressor which does not compress- it converts each
      # buffer object into a string and returns the resulting blob of
      # text.
      #
      # @api private
      #
      class Simple

        # @param (see #initialize)
        # @return (see #with)
        def self.with(content)
          new(content).with
        end

        # @param content [Array<void>]
        # @return [Vedeu::Output::Compressors::Simple]
        def initialize(content)
          @content = content
        end

        # @return [String]
        def with
          Vedeu.log(type: :compress, message: message)

          compress
        end

        protected

        # @!attribute [r] content
        # @return [void]
        attr_reader :content

        private

        # @return [String]
        def compress
          @_compress ||= content.map(&:to_s).join
        end

        # @return [Fixnum]
        def compress_size
          compress.size
        end

        # @return [String]
        def message
          "No compression for #{original_size} objects " \
          "-> #{compress_size} characters"
        end

        # @return [Fixnum]
        def original_size
          content.size
        end

      end # Simple

    end # Compressors

  end # Output

end # Vedeu
