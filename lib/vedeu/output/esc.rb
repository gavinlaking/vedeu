module Vedeu

  # Provides escape sequence strings for setting the cursor position and various
  # display related functions.
  #
  module Esc

    include Vedeu::EscapeSequences
    extend self

    # Return the stream with the escape sequences escaped so that they can be
    # printed to the terminal instead of being interpreted by the terminal which
    # will render them. This way we can see what escape sequences are being sent
    # along with the content.
    #
    # @param stream [String]
    # @return [String]
    def escape(stream = '')
      return stream if stream.nil? || stream.empty?

      stream.gsub(/\e/, '\\e')
    end

    # Return the escape sequence string from the list of recognised sequence
    # 'commands', or an empty string if the 'command' cannot be found.
    #
    # @param value [String|Symbol]
    # @return [String]
    def string(value = '')
      return '' if value.empty?

      send(value.to_sym)
    rescue NoMethodError
      ''
    end

    # Return the escape sequence to render a border character.
    #
    # @return [String]
    # @yieldreturn [void] The border character to wrap with border on and off
    #   escape sequences.
    def border
      return '' unless block_given?

      [border_on, yield, border_off].join
    end

    private

    # @return [String]
    def clear
      [colour_reset, "\e[2J"].join
    end

    # @return [String]
    def clear_line
      [colour_reset, "\e[2K"].join
    end

    # @return [String]
    def colour_reset
      [fg_reset, bg_reset].join
    end

    # @return [String]
    def normal
      [underline_off, bold_off, positive].join
    end

    # @return [String]
    def screen_init
      [reset, clear, hide_cursor].join
    end

    # @return [String]
    def screen_exit
      [show_cursor, colour_reset, reset, last_character_position, "\n"].join
    end

    # @return [String]
    def last_character_position
      Vedeu::Position[Vedeu.height, Vedeu.width].to_s
    end

  end # Esc

end # Vedeu
