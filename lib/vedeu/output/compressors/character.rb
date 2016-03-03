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
        # @return (see #with)
        def self.with(content)
          new(content).with
        end

        # @param content [Array<void>]
        # @return [Vedeu::Output::Compressors::Character]
        def initialize(content)
          @content = content
          @colour  = ''
          @style   = ''
        end

        # @return [String]
        def with
          @same = ''
          @compress ||= Vedeu.timer(message) do
            out = content.map do |cell|
              "#{cell.position}"    \
              "#{colour_for(cell)}" \
              "#{style_for(cell)}"  \
              "#{cell.value}"
            end.join

            Vedeu.log(type:    :compress,
                      message: "#{message} -> #{out.size} characters")

            out
          end
        end

        protected

        # @!attribute [r] content
        # @return [void]
        attr_reader :content

        private

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
          "Compression for #{original_size} objects"
        end

        # @return [Fixnum]
        def original_size
          content.size
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

      end # Character

    end # Compressors

  end # Output

end # Vedeu
