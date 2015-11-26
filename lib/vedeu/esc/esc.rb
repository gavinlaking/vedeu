require 'vedeu/esc/actions'
require 'vedeu/esc/borders'
require 'vedeu/esc/colours'

module Vedeu

  module EscapeSequences

    # Provides escape sequence strings for setting the cursor position
    # and various display related functions.
    #
    module Esc

      include Vedeu::Common
      include Vedeu::EscapeSequences::Actions
      include Vedeu::EscapeSequences::Borders
      include Vedeu::EscapeSequences::Colours
      include Vedeu::EscapeSequences::Mouse
      extend self

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
        return ''.freeze if value.empty?

        send(value)
      rescue NoMethodError
        ''.freeze
      end

      # Return the escape sequence to render a border character.
      #
      # @return [String]
      # @yieldreturn [void] The border character to wrap with border
      #   on and off escape sequences.
      def border
        return '' unless block_given?

        "#{border_on}#{yield}#{border_off}".freeze
      end

      # @return [String]
      def clear
        "#{colour_reset}\e[2J".freeze
      end

      # @return [String]
      def screen_init
        "#{reset}#{clear}#{hide_cursor}#{enable_mouse}".freeze
      end

      # @return [String]
      def screen_exit
        "#{disable_mouse}#{show_cursor}#{screen_colour_reset}#{reset}" \
        "#{last_character_position}\n".freeze
      end

      private

      # @return [String]
      def clear_line
        "#{colour_reset}\e[2K".freeze
      end

      # @return [String]
      def colour_reset
        Vedeu::Configuration.colour.to_s
      end

      # @return [String]
      def disable_mouse
        if Vedeu::Configuration.mouse == true
          "#{mouse_x10_off}".freeze

        else
          ''.freeze

        end
      end

      # @return [String]
      def enable_mouse
        if Vedeu::Configuration.mouse == true
          "#{mouse_x10_on}".freeze

        else
          ''.freeze

        end
      end

      # @return [String]
      def normal
        "#{underline_off}#{bold_off}#{positive}".freeze
      end

      # @return [String]
      def screen_colour_reset
        "#{fg_reset}#{bg_reset}".freeze
      end

      # @return [String]
      def last_character_position
        Vedeu::Geometries::Position[Vedeu.height, Vedeu.width].to_s
      end

    end # Esc

  end # EscapeSequences

end # Vedeu
