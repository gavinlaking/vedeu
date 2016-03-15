# frozen_string_literal: true

module Vedeu

  module EscapeSequences

    # Provides escape sequence strings for setting the cursor position
    # and various display related functions.
    #
    module Esc

      include Vedeu::Common
      include Vedeu::EscapeSequences::Actions
      include Vedeu::EscapeSequences::Background
      include Vedeu::EscapeSequences::Borders
      include Vedeu::EscapeSequences::Colours
      include Vedeu::EscapeSequences::Foreground
      include Vedeu::EscapeSequences::Mouse
      extend self

      # @return [Vedeu::EscapeSequences::Esc]
      def esc
        self
      end

      # Return the stream with the escape sequences escaped so that
      # they can be printed to the terminal instead of being
      # interpreted by the terminal which will render them. This way
      # we can see what escape sequences are being sent along with
      # the content.
      #
      # @param stream [String]
      # @return [String]
      def escape(stream = '')
        return stream if absent?(stream)

        stream.gsub(/\e/, '\\e')
      end

      # Return the escape sequence string from the list of recognised
      # sequence 'commands', or an empty string when the 'command'
      # cannot be found.
      #
      # @param value [String|Symbol]
      # @return [String]
      def string(value = '')
        return '' unless present?(value)

        send(value)
      rescue NoMethodError
        ''
      end

      # Return the escape sequence to render a border character.
      #
      # @macro param_block
      # @return [String]
      # @yieldreturn [void] The border character to wrap with border
      #   on and off escape sequences.
      def border(&block)
        return '' unless block_given?

        border_on + yield + border_off
      end

      # @return [String]
      def clear
        "#{colour_reset}\e[2J"
      end

      # @return [String]
      def screen_init
        "#{reset}#{clear}#{hide_cursor}#{enable_mouse}"
      end

      # @return [String]
      def screen_exit
        "#{disable_mouse}#{show_cursor}#{screen_colour_reset}#{reset}" \
        "#{last_character_position}\n"
      end

      # @return [String]
      def clear_line
        "#{colour_reset}\e[2K"
      end

      # @return [String]
      def colour_reset
        Vedeu::Colours::Colour.coerce(Vedeu.config.colour).to_s
      end

      # @return [String]
      def normal
        "#{underline_off}#{bold_off}#{positive}"
      end

      # @return [String]
      def screen_colour_reset
        "#{fg_reset}#{bg_reset}"
      end

      # @return [String]
      def last_character_position
        Vedeu::Geometries::Position.coerce([Vedeu.height, Vedeu.width]).to_s
      end

    end # Esc

  end # EscapeSequences

  def_delegators Vedeu::EscapeSequences::Esc.esc,
                 :esc

end # Vedeu
