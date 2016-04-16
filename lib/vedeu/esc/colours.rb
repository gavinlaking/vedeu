# frozen_string_literal: true

module Vedeu

  module EscapeSequences

    # Provides colour related escape sequences.
    #
    # @api private
    #
    module Colours

      include Vedeu::Common
      extend self

      # Produces the background named colour escape sequence hash from
      # the foreground escape sequence hash.
      #
      # @return [Hash<Symbol => Fixnum>]
      def background_codes
        foreground_codes.each_with_object({}) do |(k, v), h|
          h[k] = v + 10
          h
        end
      end

      # @param named_colour [Symbol]
      # @macro param_block
      # @return [String]
      def background_colour(named_colour, &block)
        return '' unless valid_name?(named_colour)

        colour(named_colour.to_s.prepend('on_').to_sym, &block)
      end

      # @param named_colour [Symbol]
      # @macro param_block
      # @return [String]
      def colour(named_colour, &block)
        return '' unless valid_name?(named_colour)

        public_send(named_colour, &block)
      end
      alias foreground_colour colour

      # Produces the foreground named colour escape sequence hash. The
      # background escape sequences are also generated from this by
      # adding 10 to the values.
      # This hash gives rise to methods you can call directly on `Esc`
      # to produce the desired colours:
      #
      # @example
      #   # "\e[31m"
      #   Vedeu::EscapeSequences::Esc.red
      #
      #   # "\e[31msome text\e[39m"
      #   Vedeu::EscapeSequences::Esc.red { 'some text' }
      #
      #   # "\e[44m"
      #   Vedeu::EscapeSequences::Esc.on_blue
      #
      #   # "\e[44msome text\e[49m"
      #   Vedeu::EscapeSequences::Esc.on_blue { 'some text' }
      #
      #   # Valid names:
      #   :black, :red, :green, :yellow, :blue, :magenta, :cyan,
      #   :light_grey, :default, :dark_grey, :light_red, :light_green,
      #   :light_yellow, :light_blue, :light_magenta, :light_cyan,
      #   :white
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

      # @return [Array<Symbol>]
      def valid_codes
        @_valid_codes ||= foreground_codes.keys.map do |name|
          name.to_s.prepend('on_').to_sym
        end + foreground_codes.keys
      end

      # Returns a boolean indicating whether the colour provided is a
      # valid named colour.
      #
      # @param named_colour [Symbol]
      # @return [Boolean]
      def valid_name?(named_colour)
        return false unless symbol?(named_colour)

        valid_codes.include?(named_colour)
      end

    end # Colours

  end # EscapeSequences

end # Vedeu
