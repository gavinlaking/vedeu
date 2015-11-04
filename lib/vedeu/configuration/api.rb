module Vedeu

  module Config

    # The Configuration::API class parses client application
    # configuration into options used by Vedeu to affect certain
    # behaviours.
    #
    class API

      include Vedeu::Common

      # @param (see #initialize)
      def self.configure(&block)
        new(&block).configuration
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
      # @param block [Proc]
      # @return [Vedeu::Configuration::API]
      def initialize(&block)
        instance_eval(&block) if block_given?
      end

      # Returns the configuration options set up by the API DSL.
      #
      # @return [Hash<Symbol => Boolean, Fixnum, String>]
      def configuration
        Vedeu::Config
          .log(Vedeu::EscapeSequences::Esc.green { '[api]' }, options)
      end

      # Sets boolean to allow user input. The default behaviour of
      # Vedeu is to be interactive.
      #
      #   Vedeu.configure do
      #     interactive! # => same as `interactive true` or
      #                  #    `standalone false`
      #     # ...
      #   end
      #
      #   Vedeu.configure do
      #     interactive true # => Allow user input.
      #     # ...
      #   end
      #
      #   Vedeu.configure do
      #     interactive false # => Disallow user input.
      #     # ...
      #   end
      #
      # @param value [Boolean]
      # @return [Boolean]
      def interactive!(value = true)
        options[:interactive] = value
      end
      alias_method :interactive, :interactive!

      # Sets boolean to prevent user intervention. This is the same as
      # setting {include:Vedeu::Config::API#interactive!} to false.
      #
      #   Vedeu.configure do
      #     standalone! # => same as `standalone true` or
      #                 #    `interactive false`
      #     # ...
      #   end
      #
      #   Vedeu.configure do
      #     standalone true # => Disallow user input.
      #     # ...
      #   end
      #
      #   Vedeu.configure do
      #     standalone false # => Allow user input.
      #     # ...
      #   end
      #
      # @param value [Boolean]
      # @return [Boolean]
      def standalone!(value = true)
        options[:interactive] = !value
      end
      alias_method :standalone, :standalone!

      # Sets boolean to run the Vedeu main application loop once. In
      # effect, using `run_once!` or setting `run_once` to true will
      # allow Vedeu to initialize, run any client application code,
      # cleanup, then terminate.
      #
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

      # Sets the terminal mode to `cooked`. Default terminal mode is
      # `raw`. Also, see {Vedeu::Config::API#raw!}
      #
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

      # Sets the terminal mode to `fake`. Default terminal mode is
      # `raw`.
      #
      # @example
      #   Vedeu.configure do
      #     fake!
      #     # ...
      #   end
      #
      # @return [Boolean]
      def fake!
        options[:terminal_mode] = :fake
      end
      alias_method :fake, :fake!

      # Sets the terminal mode to `raw`. Default terminal mode is
      # `raw`. Also, see {Vedeu::Config::API#cooked!}
      #
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

      # Sets boolean to enable/disable debugging. Vedeu's default
      # setting is for debugging to be disabled. Using `debug!` or
      # setting `debug` to true will enable debugging.
      #
      # At this time, debugging only toggles between viewing a full
      # backtrace (true) upon exception or only its top line (false).
      #
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
      #   Vedeu.configure do
      #     colour_mode 256
      #     # ...
      #   end
      #
      # @note
      #   iTerm 2 on Mac OSX will handle the true colour setting
      #   (16777216), whereas Terminator on Linux will not display
      #   colours correctly. For compatibility across platforms, it is
      #   recommended to either not set the colour mode at all and
      #   allow it to be detected, or use 256 here.
      #
      # @param value [Fixnum]
      # @raise [Vedeu::Error::InvalidSyntax] When the value parameter
      #   is not one of +8+, +16+, +256+ or +16777216+.
      # @return [Boolean]
      def colour_mode(value = nil)
        unless valid_colour_mode?(value)
          fail Vedeu::Error::InvalidSyntax,
               '`colour_mode` must be `8`, `16`, `256`, `16777216`.'
        end

        options[:colour_mode] = value
      end

      # Sets the height of the terminal.
      #
      #   Vedeu.configure do
      #     height 25
      #     # ...
      #   end
      #
      # @param height [Fixnum]
      # @return [Fixnum]
      def height(height = 25)
        options[:height] = height
      end

      # Sets the location of the log file.
      #
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

      # Only log specific message types. A complete list of message
      # types can be found at {Vedeu::Logging::Log.message_types}.
      #
      #   Vedeu.configure do
      #     log_only :debug, :event
      #
      #     # or
      #     log_only [:debug, :info]
      #
      #     # ...
      #   end
      #
      # @param types [Array<Symbol>] The message types which should be
      #   logged.
      # @return [Array<Symbol>]
      def log_only(*types)
        options[:log_only] = types.flatten
      end

      # Sets boolean to enable/disable profiling. Vedeu's default
      # setting is for profiling to be disabled. Using `profile!` or
      # setting `profile` to true will enable profiling.
      #
      # Profile uses 'ruby-prof' to write a 'profile.html' file to
      # the /tmp directory which contains a call trace of the running
      # application. Upon exit, this file can be examined to ascertain
      # certain behaviours of Vedeu.
      #
      # @note
      #   Be aware that running an application with profiling enabled
      #   will affect performance.
      #
      #   Vedeu.configure do
      #     profile!
      #     # ...
      #   end
      #
      #   Vedeu.configure do
      #     profile false
      #     # ...
      #   end
      #
      # @param value [Boolean]
      # @return [Boolean]
      def profile!(value = true)
        options[:profile] = value
      end
      alias_method :profile, :profile!

      # Sets the renderers for Vedeu. Each renderer added must have
      # the class method '.render' defined as this will be called when
      # rendering content.
      #
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
        options[:renderers] = renderer
      end
      alias_method :renderers, :renderer

      # Override the base path for the application (for locating
      # templates and other resources). By default the base path is
      # just cwd but this will not work for many applications.
      #
      #   Vedeu.configure do
      #     base_path '/path/to/application'
      #     # ...
      #   end
      #
      # @param path [String]
      # @return [String]
      def base_path(path = nil)
        options[:base_path] = path
      end

      # Sets the root of the client application. Vedeu will execute
      # this controller with action and optional arguments first.
      #
      #   Vedeu.configure do
      #     root :controller, :action, args
      #     # ...
      #   end
      #
      # @param args [Array<Symbol|void>]
      # @return [Class]
      def root(*args)
        options[:root] = args
      end

      # Sets the value of STDIN.
      #
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

      # Compression reduces the number of escape sequences being sent
      # to the terminal which improves redraw/render/refresh rate. By
      # default it is enabled.
      #
      # Sets boolean to enable/disable compression. Vedeu's default
      # setting is for compression to be enabled. Setting
      # `compression` to false will disable compression.
      #
      #   Vedeu.configure do
      #     compression! # enabled (default)
      #     # ...
      #   end
      #
      #   Vedeu.configure do
      #     compression false
      #     # ...
      #   end
      #
      # @note
      # - Be aware that running an application without compression
      #   will affect performance.
      #
      # @param value [Boolean]
      # @return [Boolean]
      def compression(value = true)
        options[:compression] = value
      end
      alias_method :compression!, :compression

      # Sets the terminal mode. Valid values can be either ':cooked',
      # ':fake' or :raw'.
      #
      #   Vedeu.configure do
      #     terminal_mode :cooked
      #
      #     # or...
      #
      #     terminal_mode :fake
      #
      #     # or...
      #
      #     terminal_mode :raw
      #
      #     # ... some code
      #   end
      #
      # @param mode [Symbol] Either ':cooked', ':fake' or ':raw'.
      # @raise [Vedeu::Error::InvalidSyntax] When the mode is not
      #   ':cooked', ':fake' or ':raw'.
      # @return [Symbol]
      # @see Vedeu::Config::API#cooked!
      # @see Vedeu::Config::API#fake!
      # @see Vedeu::Config::API#raw!
      def terminal_mode(mode)
        return invalid_mode! unless valid_mode?(mode)

        options[:terminal_mode] = mode
      end

      # Sets the width of the terminal.
      #
      #   Vedeu.configure do
      #     width 80
      #     # ...
      #   end
      #
      # @param width [Fixnum]
      # @return [Fixnum]
      def width(width = 80)
        options[:width] = width
      end

      # Sets the background of the terminal.
      #
      #   Vedeu.configure do
      #     background '#ff0000'
      #     # ...
      #   end
      #
      # @param value [String]
      # @return [Vedeu::Colours::Background]
      def background(value = nil)
        return options[:background] unless value

        options[:background] = colour_attributes(
          background: Vedeu::Colours::Background.coerce(value)
        ).fetch(:background)
      end

      # Sets the foreground of the terminal.
      #
      #   Vedeu.configure do
      #     foreground '#ffff00'
      #     # ...
      #   end
      #
      # @param value [String]
      # @return [Vedeu::Colours::Foreground]
      def foreground(value = nil)
        return options[:foreground] unless value

        options[:foreground] = colour_attributes(
          foreground: Vedeu::Colours::Foreground.coerce(value)
        ).fetch(:foreground)
      end

      # Sets the background and foreground of the terminal.
      #
      #   Vedeu.configure do
      #     colour background: '#ff0000', foreground: '#ffff00'
      #     # ...
      #   end
      #
      # @param attrs [Hash<Symbol => String>]
      # @return [Hash]
      def colour(attrs = {})
        options[:background] = background(attrs[:background])
        options[:foreground] = foreground(attrs[:foreground])
        options
      end

      private

      # @params attrs [Hash<Symbol => Vedeu::Colours::Background,
      #   Vedeu::Colours::Foreground>]
      # @options attrs background [Vedeu::Colours::Background]
      # @options attrs foreground [Vedeu::Colours::Foreground]
      # @return [Hash<Symbol => Symbol>]
      def colour_attributes(attrs = {})
        {
          background: Vedeu::Configuration.background,
          foreground: Vedeu::Configuration.foreground,
        }.merge!(attrs)
      end

      # @raise [Vedeu::Error::InvalidSyntax]
      def invalid_mode!
        fail Vedeu::Error::InvalidSyntax,
             'Terminal mode can be set to either :cooked, :fake or :raw'.freeze
      end

      # Returns the options set via the configuration API DSL or an
      # empty Hash when none were set.
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
