# frozen_string_literal: true

module Vedeu

  module Output

    module Compressors

      # The empty compressor removes all empty cells.
      #
      # @api private
      #
      class Empty

        # @param (see #initialize)
        # @return (see #compress)
        def self.with(content)
          new(content).compress
        end

        # @param content [Array<void>]
        # @return [Vedeu::Output::Compressors::Empty]
        def initialize(content)
          @content = content
        end

        # @return [Array]
        def compress
          Vedeu.timer('Removing empty cells...') do
            content.reject { |cell| cell.class == Vedeu::Cells::Empty }
          end.tap do |out|
            Vedeu.log(type:    :compress,
                      message: "#{message} -> #{out.size} objects")
          end
        end

        protected

        # @!attribute [r] content
        # @return [void]
        attr_reader :content

        private

        # @return [String]
        def message
          "Compression for #{content.size} objects"
        end

      end # Empty

    end # Compressors

  end # Output

end # Vedeu
