module Vedeu

  module Borders

    # When a {Vedeu::Borders::Border} has a caption, truncate it if
    # the caption is longer than the interface is wide, and pad with a
    # space either side.
    #
    # @api private
    #
    class Caption < Title

      # Overwrite the border from
      # {Vedeu::Borders::Border#build_horizontal} on the bottom border
      # to include the caption if given.
      #
      # @return [Array<Vedeu::Views::Char>]
      def render
        return chars if empty?

        caption_index = 0
        chars.each_with_index do |char, index|
          next if index <= start_index || index > (width - 2)

          char.border   = nil
          char.value    = characters[caption_index]
          caption_index += 1
        end
      end

      private

      # @return [Fixnum]
      def start_index
        (width - size) - 2
      end

    end # Caption

  end # Borders

end # Vedeu
