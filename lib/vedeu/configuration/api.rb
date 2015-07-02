module Vedeu

  module Config

    # The Configuration::API class parses client application configuration into
    # options used by Vedeu to affect certain behaviours.
    #
    # @api public
    class API

      include Vedeu::Common

      # @param (see #initialize)
      def self.configure(&block)
        new(&block).configuration
      end

      # Returns a new instance of Vedeu::Config::API.
      #
      # Configure Vedeu via a simple configuration API DSL. Options set here
      # override the default Vedeu configuration set in
      # {Vedeu::Configuration#defaults}.
      #
      # @example
      #   Vedeu.configure do
      #     # ...
      #   end
      #
      # @param block [Proc]
      # @return [Configuration::API]
      def initialize(&block)
        instance_eval(&block) if block_given?
      end

      # Returns the configuration options set up by the API DSL.
      #
      # @return [Hash<Symbol => Boolean, Fixnum, String>]
      def configuration
        Vedeu::Config.log(Esc.green { '[api]' }, options)
      end

      # Sets boolean to allow user input. The default behaviour of Vedeu is to
      # be interactive.
      #
      # @example
      #   Vedeu.configure do
      #     interactive!
      #     # ...
      #   end
      #
      #   Vedeu.configure do
      #     interactive false
      #     # ...
      #   end
      #
      # @param value [Boolean]
      # @return [Boolean]
      def interactive!(value = true)
        options[:interactive] = value
      end
      alias_method :interactive, :interactive!

      # Sets boolean to prevent user intervention. This is the same as setting
      # {#interactive!} to false.
      #
      # @example
      #   Vedeu.configure do
      #     standalone!
      #     # ...
      #   end
      #
      # @param value [Boolean]
      # @return [Boolean]
      def standalone!(value = true)
        options[:interactive] = !value
      end
      alias_method :standalone, :standalone!

      # Sets boolean to run the Vedeu main application loop once. In effect,
      # using `run_once!` or setting `run_once` to true will allow Vedeu to
      # initialize, run any client application code, cleanup, then terminate.
      #
      # @example
      #   Vedeu.configure do
      #     run_once!
      #     # ...
      #   end
      #
      # @param value [Boolean]
      # @return [Boolean]
      def run_once!(value = true)
        options[:once] = value
      end
      alias_method :run_once, :run_once!

      # Sets boolean to run a DRb server.
      #
      # @example
      #   Vedeu.configure do
      #     drb!
      #     # ...
      #   end
      #
      # @param value [Boolean]
      # @return [Boolean]
      def drb!(value = true)
        options[:drb] = value
      end
      alias_method :drb, :drb!

      # Sets the hostname or IP address of the DRb server.
      #
      # @example
      #   Vedeu.configure do
      #     drb_host 'localhost'
      #     # ...
      #   end
      #
      # @param hostname [String]
      # @return [String]
      def drb_host(hostname = '')
        options[:drb_host] = hostname
      end

      # Sets the port of the DRb server.
      #
      # @example
      #   Vedeu.configure do
      #     drb_port 12345
      #     # ...
      #   end
      #
      # @param port [Fixnum|String]
      # @return [String]
      def drb_port(port = '')
        options[:drb_port] = port
      end

      # Sets the height of the fake terminal in the DRb server.
      #
      # @example
      #   Vedeu.configure do
      #     drb_height 25
      #     # ...
      #   end
      #
      # @param height [Fixnum]
      # @return [Fixnum]
      def drb_height(height = 25)
        options[:drb_height] = height
      end

      # Sets the width of the fake terminal in the DRb server.
      #
      # @example
      #   Vedeu.configure do
      #     drb_width 80
      #     # ...
      #   end
      #
      # @param width [Fixnum]
      # @return [Fixnum]
      def drb_width(width = 80)
        options[:drb_width] = width
      end

      # Sets the terminal mode to `cooked`. Default terminal mode is `raw`.
      #
      # @example
      #   Vedeu.configure do
      #     cooked!
      #     # ...
      #   end
      #
      # @return [Boolean]
      def cooked!
        options[:terminal_mode] = :cooked
      end
      alias_method :cooked, :cooked!

      # Sets the terminal mode to `raw`. Default terminal mode is `raw`.
      #
      # @example
      #   Vedeu.configure do
      #     raw!
      #     # ...
      #   end
      #
      # @return [Boolean]
      def raw!
        options[:terminal_mode] = :raw
      end
      alias_method :raw, :raw!

      # Sets boolean to enable/disable debugging. Vedeu's default setting is
      # for debugging to be disabled. Using `debug!` or setting `debug` to true
      # will enable debugging.
      #
      # @note
      #   Be aware that running an application with debugging enabled will
      #   affect performance.
      #
      # @example
      #   Vedeu.configure do
      #     debug!
      #     # ...
      #   end
      #
      #   Vedeu.configure do
      #     debug false
      #     # ...
      #   end
      #
      # @param value [Boolean]
      # @return [Boolean]
      def debug!(value = true)
        options[:debug] = value
      end
      alias_method :debug, :debug!

      # Sets the colour mode of the terminal.
      #
      # @example
      #   Vedeu.configure do
      #     colour_mode 256
      #     # ...
      #   end
      #
      # @note
      #   iTerm 2 on Mac OSX will handle the true colour setting (16777216),
      #   whereas Terminator on Linux will not display colours correctly. For
      #   compatibility across platforms, it is recommended to either not set
      #   the colour mode at all and allow it to be detected, or use 256 here.
      #
      # @param value [Fixnum]
      # @raise [InvalidSyntax] When the value parameter is not one of +8+, +16+,
      #   +256+ or +16777216+.
      # @return [Boolean]
      def colour_mode(value = nil)
        fail InvalidSyntax, '`colour_mode` must be `8`, `16`, `256`, ' \
                            '`16777216`.' unless valid_colour_mode?(value)
        options[:colour_mode] = value
      end

      # Sets the location of the log file.
      #
      # @example
      #   Vedeu.configure do
      #     log '/var/log/vedeu.log'
      #     # ...
      #   end
      #
      # @param filename [String]
      # @return [String]
      def log(filename = '')
        options[:log] = filename
      end

      # Sets the renderers for Vedeu. Each renderer added must have the class
      # method '.render' defined as this will be called when rendering content.
      #
      # @example
      #   Vedeu.configure do
      #     renderer MyRenderer
      #     # ...
      #   end
      #
      #   Vedeu.configure do
      #     renderers MyRenderer, MyOtherRenderer
      #     # ...
      #   end
      #
      # @param renderer [Array<Class>|Class]
      # @return [Array<Class>]
      def renderer(*renderer)
        options[:renderers] = Vedeu::Configuration.renderers + renderer
      end
      alias_method :renderers, :renderer

      # Sets the value of STDIN.
      #
      # @example
      #   Vedeu.configure do
      #     stdin IO.console
      #     # ...
      #   end
      #
      # @param io [File|IO]
      # @return [File|IO]
      def stdin(io)
        options[:stdin] = io
      end

      # Sets the value of STDOUT.
      #
      # @example
      #   Vedeu.configure do
      #     stdout IO.console
      #     # ...
      #   end
      #
      # @param io [File|IO]
      # @return [File|IO]
      def stdout(io)
        options[:stdout] = io
      end

      # Sets the value of STDERR.
      #
      # @example
      #   Vedeu.configure do
      #     stderr IO.console
      #     # ...
      #   end
      #
      # @param io [File|IO]
      # @return [File|IO]
      def stderr(io)
        options[:stderr] = io
      end

      private

      # Returns the options set via the configuration API DSL or an empty Hash
      # if none were set.
      #
      # @return [Hash]
      def options
        @options ||= {}
      end

      # Checks that the value provided to {#colour_mode} is valid.
      #
      # @param value [Fixnum]
      # @return [Boolean]
      def valid_colour_mode?(value)
        value.is_a?(Fixnum) && [8, 16, 256, 16_777_216].include?(value)
      end

      # Checks that the value provided to {#exit_key}, {#focus_next_key},
      # {#focus_prev_key} and {#mode_switch_key} is valid. Must be a Symbol or a
      # non-empty String.
      #
      # @param value [String|Symbol]
      # @return [Boolean]
      def valid_key?(value)
        return false unless value.is_a?(String) || value.is_a?(Symbol)

        return false if value.is_a?(String) && value.size != 1

        (value.is_a?(String) || value.is_a?(Symbol)) && present?(value)
      end

    end # API

  end # Config

end # Vedeu
