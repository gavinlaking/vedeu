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

        # Process the content as a stream; for each sequence with the
        # same position take the first sequence and ignore the rest.
        #
        # @return [String]
        def with
          @same = ''
          @compress ||= Vedeu.timer(message) do
            content.map do |cell|
              character = [
                position_for(cell),
                colour_for(cell),
                style_for(cell),
                value_for(cell),
              ].join

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
