# frozen_string_literal: true

module Vedeu

  module Colours

    # Provides a container for terminal escape sequences controlling
    # the foreground and background colours of a character or
    # collection of characters.
    #
    # Vedeu uses HTML/CSS style notation (i.e. '#aadd00'), they can be
    # used at the stream level, the line level or for the whole
    # interface. Terminals generally support either 8, 16 or 256
    # colours, with few supporting full 24-bit colour (see notes
    # below).
    #
    # Vedeu attempts to detect the colour depth using the `$TERM`
    # environment variable.
    #
    # To set your `$TERM` variable to allow 256 colour support:
    #
    # ```bash
    # echo "export TERM=xterm-256color" >> ~/.bashrc
    # ```
    #
    # Notes:
    # Terminals which support the 24-bit colour mode include (but are
    # not limited to): iTerm2 (OSX), Gnome Terminal (Linux).
    #
    # Setting your `$TERM` environment variable as above gets you up
    # to 256 colours, but when you then add the
    # `colour_mode 16_777_216` configuration to your client
    # application, it's really a hit and miss affair. iTerm2 renders
    # all the colours correctly as does Gnome Terminal. Terminator
    # (Linux) goes crazy though and defaults to 16 colours despite the
    # `$TERM` setting. This area needs more work in Vedeu.
    #
    # @todo Fix colours in all terminals. (GL: 2015-04-13)
    #
    # @api private
    #
    class Colour

      class << self

        extend Forwardable

        def_delegators Vedeu::Coercers::Colour,
                       :coerce

        # @return [Vedeu::Colours::Colour]
        def default
          new(background: :default, foreground: :default)
        end

      end # Eigenclass

      extend Forwardable

      def_delegators :background,
                     :background?

      def_delegators :foreground,
                     :foreground?

      include Vedeu::Repositories::Defaults

      # @return [Hash<Symbol => Vedeu::Colours::Background,
      #   Vedeu::Colours::Foreground>]
      def attributes
        {
          background: background,
          foreground: foreground,
        }
      end

      # @return [Vedeu::Colours::Background]
      def background
        Vedeu::Colours::Background.coerce(@background)
      end

      # Converts the value into a Vedeu::Colours::Background.
      #
      # @param value [String]
      # @return [Vedeu::Colours::Foreground]
      def background=(value)
        @background = Vedeu::Colours::Background.coerce(value)
      end

      # An object is equal when its values are the same.
      #
      # @param other [void]
      # @return [Boolean]
      def eql?(other)
        self.class.equal?(other.class) &&
          background == other.background &&
          foreground == other.foreground
      end
      alias == eql?

      # @return [Vedeu::Colours::Foreground]
      def foreground
        Vedeu::Colours::Foreground.coerce(@foreground)
      end

      # Converts the value into a Vedeu::Colours::Foreground.
      #
      # @param value [String]
      # @return [Vedeu::Colours::Foreground]
      def foreground=(value)
        @foreground = Vedeu::Colours::Foreground.coerce(value)
      end

      # @return [String]
      def to_ast
        [foreground.to_ast, background.to_ast].reject do |value|
          absent?(value)
        end.join(' ')
      end

      # @return [Hash<Symbol => Hash<Symbol => String>>]
      def to_h
        {
          colour: background.to_h.merge!(foreground.to_h),
        }
      end
      alias to_hash to_h

      # Returns both or either of the converted attributes into a
      # single escape sequence.
      #
      # @return [String]
      def to_s
        "#{foreground}#{background}"
      end
      alias to_str to_s

      private

      # @macro defaults_method
      def defaults
        {
          background: Vedeu::Colours::Background.new,
          foreground: Vedeu::Colours::Foreground.new,
        }
      end

    end # Colour

  end # Colours

end # Vedeu
