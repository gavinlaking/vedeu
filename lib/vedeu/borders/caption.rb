module Vedeu

  module Borders

    # When a {Vedeu::Borders::Border} has a caption, truncate it if
    # the caption is longer than the interface is wide, and pad with a
    # space either side.
    #
    # @api private
    #
    class Caption < Title

      # Overwrite the border from {#build_horizontal} on the bottom
      # border to include the caption if given.
      #
      # @param [Array<Vedeu::Views::Char>]
      # @return [Array<Vedeu::Views::Char>]
      def render
        return chars if empty?

        caption_index = 0
        chars.each_with_index do |char, index|
          next if index <= start_index || index > (width - 4)

          char.border   = nil
          char.value    = characters[caption_index]
          caption_index += 1
        end
      end

      private

      # @return [Fixnum]
      def start_index
        (width - size) - 4
      end

    end # Caption

  end # Borders

end # Vedeu
