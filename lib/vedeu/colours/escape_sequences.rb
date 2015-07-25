module Vedeu

  # Provides escape sequence strings for terminal colours and some actions.
  #
  module EscapeSequences

    extend self

    # @return [Hash<Symbol => String>]
    def actions
      {
        hide_cursor:     "\e[?25l",
        show_cursor:     "\e[?25h",
        cursor_position: "\e[6n",
        bg_reset:        "\e[49m",
        blink:           "\e[5m",
        blink_off:       "\e[25m",
        bold:            "\e[1m",
        bold_off:        "\e[22m",
        border_on:       "\e(0",
        border_off:      "\e(B",
        dim:             "\e[2m",
        fg_reset:        "\e[39m",
        negative:        "\e[7m",
        positive:        "\e[27m",
        reset:           "\e[0m",
        underline:       "\e[4m",
        underline_off:   "\e[24m",
      }
    end

    # Produces the background named colour escape sequence hash from the
    # foreground escape sequence hash.
    #
    # @return [Hash<Symbol => Fixnum>]
    def background_codes
      hash = {}
      Vedeu::EscapeSequences.foreground_codes.inject(hash) do |h, (k, v)|
        h.merge!(k => v + 10)
      end
    end

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
    #   :black, :red, :green, :yellow, :blue, :magenta, :cyan, :light_grey,
    #   :default, :dark_grey, :light_red, :light_green, :light_yellow,
    #   :light_blue, :light_magenta, :light_cyan, :white
    #
    # @return [Hash<Symbol => Fixnum>]
    def foreground_codes
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
    alias_method :codes, :foreground_codes

    # @return [void]
    def setup!
      define_actions!
      define_backgrounds!
      define_foregrounds!
    end

    private

    # @return [void]
    def define_actions!
      actions.each { |key, code| define_method(key) { code } }
    end

    # @return [void]
    def define_backgrounds!
      background_codes.each do |key, code|
        define_method('on_' + key.to_s) do |&blk|
          "\e[#{code}m" + (blk ? blk.call + "\e[49m" : '')
        end
      end
    end

    # Dynamically creates methods for each terminal named colour. When a block
    # is given, then the colour is reset to 'default' once the block is called.
    #
    # @return [void]
    def define_foregrounds!
      foreground_codes.each do |key, code|
        define_method(key) do |&blk|
          "\e[#{code}m" + (blk ? blk.call + "\e[39m" : '')
        end
      end
    end

  end # EscapeSequences

end # Vedeu

Vedeu::EscapeSequences.setup!
