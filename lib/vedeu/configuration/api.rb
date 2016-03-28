# frozen_string_literal: true

module Vedeu

  module Config

    # The Configuration::API class parses client application
    # configuration into options used by Vedeu to affect certain
    # behaviours.
    #
    class API

      include Vedeu::Common

      # @param (see #initialize)
      def self.configure(default, &block)
        new(default, &block).configuration
      end

      # Returns a new instance of Vedeu::Config::API.
      #
      # Configure Vedeu via a simple configuration API DSL. Options
      # set here override the default Vedeu configuration set in
      # {Vedeu::Configuration#defaults}.
      #
      #   Vedeu.configure do
      #     # ...
      #   end
      #
      # @param default [Hash]
      # @macro param_block
      # @return [Vedeu::Configuration::API]
      def initialize(default, &block)
        @default = default

        instance_eval(&block) if block_given?
      end

      # {include:file:docs/configuration/background.md}
      # @param value [String]
      # @return [Vedeu::Colours::Background]
      def background(value = nil)
        return options[:background] unless value

        options[:background] = value
      end

      # {include:file:docs/configuration/base_path.md}
      # @param path [String]
      # @return [String]
      def base_path(path = nil)
        options[:base_path] = path
      end

      # {include:file:docs/configuration/colour.md}
      # @param attrs [Hash<Symbol => String>]
      # @return [Hash<Symbol => void>]
      def colour(attrs = {})
        options[:background] = attrs[:background] if attrs.key?(:background)
        options[:foreground] = attrs[:foreground] if attrs.key?(:foreground)
        options
      end

      # {include:file:docs/configuration/colour_mode.md}
      # @param value [Fixnum]
      # @macro raise_invalid_syntax
      # @return [Boolean]
      def colour_mode(value = nil)
        unless valid_colour_mode?(value)
          raise Vedeu::Error::InvalidSyntax,
                '`colour_mode` must be `8`, `16`, `256`, `16777216`.'
        end

        options[:colour_mode] = value
      end

      # {include:file:docs/configuration/compression.md}
      # @param value [Boolean]
      # @return [Boolean]
      def compression(value = true)
        options[:compression] = value
      end
      alias compression! compression

      # Returns the configuration options set up by the API DSL.
      #
      # @return [Hash<Symbol => Boolean, Fixnum, String>]
      def configuration
        if options[:log].nil?          ||
           options[:log] == false      ||
           empty_value?(options[:log])
          Vedeu.log(type:    :config,
                    message: 'Logging has been disabled.')

          return options
        end

        log_options!

        if options[:log] != default[:log]
          Vedeu.log(message: "Switching to '#{options[:log]}' for logging.\n")
        end

        options
      end

      # {include:file:docs/configuration/cooked.md}
      # @return [Boolean]
      def cooked!
        options[:terminal_mode] = :cooked
      end
      alias cooked cooked!

      # {include:file:docs/configuration/debug.md}
      # @param value [Boolean]
      # @return [Boolean]
      def debug!(value = true)
        options[:debug] = value
      end
      alias debug debug!

      # {include:file:docs/configuration/drb.md}
      # @param value [Boolean]
      # @return [Boolean]
      def drb!(value = true)
        options[:drb] = value
      end
      alias drb drb!

      # {include:file:docs/configuration/drb_height.md}
      # @param height [Fixnum]
      # @return [Fixnum]
      def drb_height(height = 25)
        options[:drb_height] = height
      end

      # {include:file:docs/configuration/drb_host.md}
      # @param hostname [String]
      # @return [String]
      def drb_host(hostname = '')
        options[:drb_host] = hostname
      end

      # {include:file:docs/configuration/drb_port.md}
      # @param port [Fixnum|String]
      # @return [String]
      def drb_port(port = '')
        options[:drb_port] = port
      end

      # {include:file:docs/configuration/drb_width.md}
      # @param width [Fixnum]
      # @return [Fixnum]
      def drb_width(width = 80)
        options[:drb_width] = width
      end

      # {include:file:docs/configuration/fake.md}
      # @return [Boolean]
      def fake!
        options[:terminal_mode] = :fake
      end
      alias fake fake!

      # {include:file:docs/configuration/foreground.md}
      # @param value [String]
      # @return [Vedeu::Colours::Foreground]
      def foreground(value = nil)
        return options[:foreground] unless value

        options[:foreground] = value
      end

      # {include:file:docs/configuration/height.md}
      # @param height [Fixnum]
      # @return [Fixnum]
      def height(height = 25)
        options[:height] = height
      end
      alias height= height

      # {include:file:docs/configuration/interactive.md}
      # @param value [Boolean]
      # @return [Boolean]
      def interactive!(value = true)
        options[:interactive] = value
      end
      alias interactive interactive!

      # {include:file:docs/configuration/log.md}
      # @param filename_or_false [FalseClass|String]
      # @return [NilClass|String]
      def log(filename_or_false = false)
        options[:log] = if filename_or_false.nil? ||
                           filename_or_false == false ||
                           empty_value?(filename_or_false)
                          nil

                        else
                          filename_or_false

                        end
      end

      # {include:file:docs/configuration/log_except.md}
      # @param types [Array<Symbol>] The message types which should
      #   not be logged.
      # @return [Array<Symbol>]
      def log_except(*types)
        options[:log_except] = types.flatten
      end

      # {include:file:docs/configuration/log_only.md}
      # @param types [Array<Symbol>] The message types which should be
      #   logged.
      # @return [Array<Symbol>]
      def log_only(*types)
        options[:log_only] = types.flatten
      end

      # {include:file:docs/configuration/mouse.md}
      # @param value [Boolean]
      # @return [Boolean]
      def mouse!(value = true)
        options[:mouse] = value
      end
      alias mouse mouse!

      # {include:file:docs/configuration/profile.md}
      # @param value [Boolean]
      # @return [Boolean]
      def profile!(value = true)
        options[:profile] = value
      end
      alias profile profile!

      # {include:file:docs/configuration/raw.md}
      # @return [Boolean]
      def raw!
        options[:terminal_mode] = :raw
      end
      alias raw raw!

      # {include:file:docs/configuration/renderer.md}
      # @param renderer [Array<Class>|Class]
      # @return [Array<Class>]
      def renderer(*renderer)
        options[:renderers] = renderer.flatten
      end
      alias renderers renderer

      # {include:file:docs/configuration/root.md}
      # @param args [Array<Symbol|void>]
      # @return [Class]
      def root(*args)
        options[:root] = args
      end

      # {include:file:docs/configuration/run_once.md}
      # @param value [Boolean]
      # @return [Boolean]
      def run_once!(value = true)
        options[:once] = value
      end
      alias run_once run_once!

      # {include:file:docs/configuration/standalone.md}
      # @param value [Boolean]
      # @return [Boolean]
      def standalone!(value = true)
        options[:interactive] = !value
      end
      alias standalone standalone!

      # {include:file:docs/configuration/stdin.md}
      # @param io [File|IO]
      # @return [File|IO]
      def stdin(io)
        options[:stdin] = io
      end

      # {include:file:docs/configuration/stdout.md}
      # @param io [File|IO]
      # @return [File|IO]
      def stdout(io)
        options[:stdout] = io
      end

      # {include:file:docs/configuration/stderr.md}
      # @param io [File|IO]
      # @return [File|IO]
      def stderr(io)
        options[:stderr] = io
      end

      # {include:file:docs/configuration/terminal_mode.md}
      # @param mode [Symbol] Either ':cooked', ':fake' or ':raw'.
      # @macro raise_invalid_syntax
      # @return [Symbol]
      # @see Vedeu::Config::API#cooked!
      # @see Vedeu::Config::API#fake!
      # @see Vedeu::Config::API#raw!
      def terminal_mode(mode)
        return invalid_mode! unless valid_mode?(mode)

        options[:terminal_mode] = mode
      end
      alias terminal_mode= terminal_mode

      # {include:file:docs/configuration/threaded.md}
      # @param boolean [Boolean]
      # @return [Boolean]
      def threaded(boolean)
        options[:threaded] = boolean
      end
      alias threaded= threaded

      # {include:file:docs/configuration/width.md}
      # @param width [Fixnum]
      # @return [Fixnum]
      def width(width = 80)
        options[:width] = width
      end
      alias width= width

      protected

      # @!attribute [r] default
      # @return [Hash]
      attr_reader :default

      private

      # @macro raise_invalid_syntax
      def invalid_mode!
        raise Vedeu::Error::InvalidSyntax,
              'Terminal mode can be set to either :cooked, :fake or :raw'
      end

      # @return [Hash]
      def log_options!
        options.each do |option, value|
          Vedeu.log(type:    :config,
                    message: "#{option}: #{value.inspect}")
        end
      end

      # Returns the options set via the configuration API DSL or an
      # empty Hash when none were set.
      #
      # @return [Hash<Symbol => void>]
      def options
        @options ||= {}
      end

      # Checks that the value provided to {#colour_mode} is valid.
      #
      # @param value [Fixnum]
      # @return [Boolean]
      def valid_colour_mode?(value)
        numeric?(value) && [8, 16, 256, 16_777_216].include?(value)
      end

      # Checks that the mode provided is valid.
      #
      # @param mode [Symbol] :cooked, :fake or :raw are valid
      # @return [Boolean]
      def valid_mode?(mode)
        [:cooked, :fake, :raw].include?(mode)
      end

    end # API

  end # Config

end # Vedeu
