module Vedeu

  # Provides escape sequence strings for setting the cursor position and various
  # display related functions.
  #
  module Esc

    extend self

    # Produces the foreground named colour escape sequence hash. The background
    # escape sequences are also generated from this by adding 10 to the values.
    # This hash gives rise to methods you can call directly on `Esc` to produce
    # the desired colours:
    #
    # @example
    #   Esc.red                     # => "\e[31m"
    #
    #   Esc.red { 'some text' }     # => "\e[31msome text\e[39m"
    #
    #   Esc.on_blue                 # => "\e[44m"
    #
    #   Esc.on_blue { 'some text' } # => "\e[44msome text\e[49m"
    #
    #   # Valid names:
    #   :black
    #   :red
    #   :green
    #   :yellow
    #   :blue
    #   :magenta
    #   :cyan
    #   :light_grey
    #   :default
    #   :dark_grey
    #   :light_red
    #   :light_green
    #   :light_yellow
    #   :light_blue
    #   :light_magenta
    #   :light_cyan
    #   :white
    #
    # @return [Hash<Symbol => Fixnum>]
    def codes
      {
        black:         30,
        red:           31,
        green:         32,
        yellow:        33,
        blue:          34,
        magenta:       35,
        cyan:          36,
        light_grey:    37,
        default:       39,
        dark_grey:     90,
        light_red:     91,
        light_green:   92,
        light_yellow:  93,
        light_blue:    94,
        light_magenta: 95,
        light_cyan:    96,
        white:         97,
      }
    end
    alias_method :foreground_codes, :codes

    # Produces the background named colour escape sequence hash from the
    # foreground escape sequence hash.
    #
    # @return [Hash<Symbol => Fixnum>]
    def background_codes
      Vedeu::Esc.codes.inject({}) { |h, (k, v)| h.merge!(k => v + 10) }
    end

    # Dynamically creates methods for each terminal named colour. When a block
    # is given, then the colour is reset to 'default' once the block is called.
    #
    # @return [String]
    foreground_codes.each do |key, code|
      define_method(key) do |&blk|
        "\e[#{code}m" + (blk ? blk.call + "\e[39m" : '')
      end
    end

    background_codes.each do |key, code|
      define_method('on_' + key.to_s) do |&blk|
        "\e[#{code}m" + (blk ? blk.call + "\e[49m" : '')
      end
    end

    # @return [Hash<Symbol => String>]
    def actions
      {
        hide_cursor:   "\e[?25l",
        show_cursor:   "\e[?25h",
        bg_reset:      "\e[49m",
        blink:         "\e[5m",
        blink_off:     "\e[25m",
        bold:          "\e[1m",
        bold_off:      "\e[22m",
        border_on:     "\e(0",
        border_off:    "\e(B",
        dim:           "\e[2m",
        fg_reset:      "\e[39m",
        negative:      "\e[7m",
        positive:      "\e[27m",
        reset:         "\e[0m",
        underline:     "\e[4m",
        underline_off: "\e[24m",
      }
    end

    actions.each do |key, code|
      define_method(key) { code }
    end

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

    # @return [String]
    def hide_cursor
      "\e[?25l"
    end

    # @return [String]
    def show_cursor
      "\e[?25h"
    end

    # Return the escape sequence string from the list of recognised sequence
    # 'commands', or an empty string if the 'command' cannot be found.
    #
    # @param value [String|Symbol]
    # @return [String]
    def string(value = '')
      name = value.to_sym

      return '' if name.empty?

      send(name)

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
    def bg_reset
      "\e[49m"
    end

    # @return [String]
    def blink
      "\e[5m"
    end

    # @return [String]
    def blink_off
      "\e[25m"
    end

    # @return [String]
    def bold
      "\e[1m"
    end

    # @return [String]
    def bold_off
      "\e[22m"
    end

    # Returns the escape sequence to start a border.
    #
    # @return [String]
    def border_on
      "\e(0"
    end

    # Returns the escape sequence to end a border.
    #
    # @return [String]
    def border_off
      "\e(B"
    end

    # @return [String]
    def clear
      [colour_reset, "\e[2J"].join
    end

    # @return [String]
    def clear_line
      [colour_reset, "\e[2K"].join
    end

    # @return [String]
    def clear_last_line
      Vedeu::Position.new((Vedeu::Terminal.height - 1), 1).to_s { clear_line }
    end

    # @return [String]
    def colour_reset
      [fg_reset, bg_reset].join
    end

    # @return [String]
    def dim
      "\e[2m"
    end

    # @return [String]
    def fg_reset
      "\e[39m"
    end

    # @return [String]
    def negative
      "\e[7m"
    end

    # @return [String]
    def normal
      [underline_off, bold_off, positive].join
    end

    # @return [String]
    def positive
      "\e[27m"
    end

    # @return [String]
    def reset
      "\e[0m"
    end

    # @return [String]
    def screen_init
      [reset, clear, hide_cursor].join
    end

    # @return [String]
    def screen_exit
      [show_cursor, colour_reset, reset].join
    end

    # @return [String]
    def underline
      "\e[4m"
    end

    # @return [String]
    def underline_off
      "\e[24m"
    end

  end # Esc

end # Vedeu
