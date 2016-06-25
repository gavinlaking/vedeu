# frozen_string_literal: true

module Vedeu

  module Output

    module Compressors

      # A simple character based compressor which compressed based on
      # the previous character's attributes.
      #
      # @api private
      #
      class Character

        # @param (see #initialize)
        # @return (see #compress)
        def self.with(content)
          new(content).compress
        end

        # @param content [Array<void>]
        # @return [Vedeu::Output::Compressors::Character]
        def initialize(content)
          @content = content
          @colour  = ''
          @same    = ''
          @style   = ''
        end

        # Process the content as a stream; for each sequence with the
        # same position take the first sequence and ignore the rest.
        #
        # @return [String]
        def compress
          Vedeu.timer('Removing duplicate cells...') do
            content.map do |cell|
              character = character_for(cell)

              character == @same ? next : @same = character
            end.join.tap do |out|
              Vedeu.log(type:    :compress,
                        message: "#{message} -> #{out.size} characters")
            end
          end
        end

        protected

        # @!attribute [r] content
        # @return [void]
        attr_reader :content

        private

        # @param char [Vedeu::Cells::Char]
        # @return [String]
        def character_for(char)
          position_for(char) +
            colour_for(char) +
            style_for(char) +
            value_for(char)
        end

        # Compress by not repeatedly sending the same colours for each
        # character which has the same colours as the last character
        # output.
        #
        # @param char [Vedeu::Cells::Char]
        # @return [String]
        def colour_for(char)
          return '' if char.colour == @colour

          @colour = char.colour
          @colour.to_s
        end

        # @return [String]
        def message
          "Compression for #{content.size} objects"
        end

        # @param char [Vedeu::Cells::Char]
        # @return [String]
        def position_for(char)
          return '' unless char.position?

          char.position.to_s
        end

        # Compress by not repeatedly sending the same style(s) for each
        # character which has the same style(s) as the last character
        # output.
        #
        # @param char [Vedeu::Cells::Char]
        # @return [String]
        def style_for(char)
          return '' if char.style == @style

          @style = char.style
          @style.to_s
        end

        # @param char [Vedeu::Cells::Char]
        # @return [String]
        def value_for(char)
          return '' unless char.value?

          char.value
        end

      end # Character

    end # Compressors

  end # Output

end # Vedeu
