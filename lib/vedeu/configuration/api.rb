module Vedeu

  module Configuration

    # The Configuration::API class parses client application configuration into
    # options used by Vedeu to affect certain behaviours.
    #
    # @api private
    class API

      include Vedeu::Common

      # Configure Vedeu via a simple configuration API DSL. Options set here
      # override the default Vedeu configuration set in
      # {Vedeu::Configuration#defaults}.
      #
      # @example
      #   Vedeu.configure do
      #     ...
      #
      # @param block [Proc]
      # @return [Hash]
      def self.configure(&block)
        new(&block).configuration
      end

      # Returns an instance of Configuration::API.
      #
      # @param block [Proc]
      # @return [Configuration::API]
      def initialize(&block)
        instance_eval(&block) if block_given?
      end

      # Returns the configuration options set up by the API DSL.
      #
      # @return [Hash]
      def configuration
        if system_key_options.any?
          options.merge({ system_keys: system_key_options })

        else
          options

        end
      end

      # Sets boolean to allow user input. The default behaviour of Vedeu is to
      # be interactive.
      #
      # @example
      #   Vedeu.configure do
      #     interactive!
      #     ...
      #
      #   Vedeu.configure do
      #     interactive false
      #     ...
      #
      # @param value [Boolean]
      # @return [Boolean]
      def interactive!(value = true)
        Vedeu.log("Configuration::API interactive: #{value}")

        options[:interactive] = value
      end
      alias_method :interactive, :interactive!

      # Sets boolean to prevent user intervention. This is the same as setting
      # {#interactive!} to false.
      #
      # @example
      #   Vedeu.configure do
      #     standalone!
      #     ...
      #
      # @param value [Boolean]
      # @return [Boolean]
      def standalone!(value = true)
        Vedeu.log("Configuration::API interactive: #{!value}")

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
      #     ...
      #
      # @param value [Boolean]
      # @return [Boolean]
      def run_once!(value = true)
        Vedeu.log("Configuration::API once: #{value}")

        options[:once] = value
      end
      alias_method :run_once, :run_once!

      # Sets the terminal mode to `cooked`. Default terminal mode is `raw`.
      #
      # @example
      #   Vedeu.configure do
      #     cooked!
      #     ...
      #
      # @return [Boolean]
      def cooked!
        Vedeu.log("Configuration::API terminal_mode: :cooked")

        options[:terminal_mode] = :cooked
      end
      alias_method :cooked, :cooked!

      # Sets the terminal mode to `raw`. Default terminal mode is `raw`.
      #
      # @example
      #   Vedeu.configure do
      #     raw!
      #     ...
      #
      # @return [Boolean]
      def raw!
        Vedeu.log("Configuration::API terminal_mode: :raw")

        options[:terminal_mode] = :raw
      end
      alias_method :raw, :raw!

      # Sets boolean to enable/disable debugging. Vedeu's default setting is
      # for debugging to be disabled. Using `debug!` or setting `debug` to true
      # will enable debugging. If `trace!` is used, or `trace` is set to true,
      # debugging will be enabled, overriding any setting here.
      #
      # @example
      #   Vedeu.configure do
      #     debug!
      #     ...
      #
      #   Vedeu.configure do
      #     debug false
      #     ...
      #
      # @param value [Boolean]
      # @return [Boolean]
      def debug!(value = true)
        if options.key?(:trace) && options[:trace] != false
          Vedeu.log("Configuration::API debug: true")

          options[:debug] = true

        else
          Vedeu.log("Configuration::API debug: #{value}")

          options[:debug] = value

        end
      end
      alias_method :debug, :debug!

      # Sets boolean to enable/disable tracing. Vedeu's default setting is for
      # tracing to be disabled. Using `trace!` or setting `trace` to true will
      # enable tracing and debugging.
      #
      # @example
      #   Vedeu.configure do
      #     trace!
      #     ...
      #
      #   Vedeu.configure do
      #     trace false
      #     ...
      #
      # @param value [Boolean]
      # @return [Boolean]
      def trace!(value = true)
        options[:debug] = true if value === true

        Vedeu.log("Configuration::API trace: #{value}")

        options[:trace] = value
      end
      alias_method :trace, :trace!

      # Sets the colour mode of the terminal.
      #
      # @example
      #   Vedeu.configure do
      #     colour_mode 256
      #     ...
      #
      # @param value [Fixnum]
      # @raise [InvalidSyntax] When the value parameter is not one of +8+, +16+,
      #   +256+ or +16777216+.
      # @return [Boolean]
      def colour_mode(value = nil)
        fail InvalidSyntax, '`colour_mode` must be `8`, `16`, `256`, ' \
                            '`16777216`.' unless valid_colour_mode?(value)

        Vedeu.log("Configuration::API colour_mode: #{value}")

        options[:colour_mode] = value
      end

      # Sets the location of the log file.
      #
      # @example
      #   Vedeu.configure do
      #     log '/var/log/vedeu.log'
      #     ...
      #
      # @param filename [String]
      # @return [String]
      def log(filename = '')
        options[:log] = filename
      end

      # Sets the key used to exit the client application. The default is `q`.
      #
      # @example
      #   Vedeu.configure do
      #     exit_key 'x'
      #     ...
      #
      #   Vedeu.configure do
      #     exit_key :f4
      #     ...
      #
      # @param value [String|Symbol]
      # @return [String|Symbol]
      def exit_key(value)
        return invalid_key('exit_key') unless valid_key?(value)

        Vedeu.log("Configuration::API exit_key: #{value}")

        system_key_options[:exit] = value
      end

      # Sets the key used to switch focus to the next defined interface. The
      # default is `:tab`.
      #
      # @example
      #   Vedeu.configure do
      #     focus_next_key 'n'
      #     ...
      #
      #   Vedeu.configure do
      #     focus_next_key :right
      #     ...
      #
      # @param value [String|Symbol]
      # @return [String|Symbol]
      def focus_next_key(value)
        return invalid_key('exit_key') unless valid_key?(value)

        Vedeu.log("Configuration::API focus_next: #{value}")

        system_key_options[:focus_next] = value
      end

      # Sets the key used to switch focus to the previous interface. The default
      # is `:shift_tab`.
      #
      # @example
      #   Vedeu.configure do
      #     focus_prev_key 'p'
      #     ...
      #
      #   Vedeu.configure do
      #     focus_prev_key :left
      #     ...
      #
      # @param value [String|Symbol]
      # @return [String|Symbol]
      def focus_prev_key(value)
        return invalid_key('exit_key') unless valid_key?(value)

        Vedeu.log("Configuration::API focus_prev: #{value}")

        system_key_options[:focus_prev] = value
      end

      # Sets the key used to switch between raw and cooked mode in Vedeu. The
      # default is `:escape`.
      #
      # @example
      #   Vedeu.configure do
      #     mode_switch_key 'm'
      #     ...
      #
      #   Vedeu.configure do
      #     mode_switch_key :f1
      #     ...
      #
      # @param value [String|Symbol]
      # @return [String|Symbol]
      def mode_switch_key(value)
        return invalid_key('exit_key') unless valid_key?(value)

        Vedeu.log("Configuration::API mode_switch: #{value}")

        system_key_options[:mode_switch] = value
      end

      private

      # Returns the options set via the configuration API DSL or an empty Hash
      # if none were set.
      #
      # @return [Hash]
      def options
        @_options ||= {}
      end

      # Returns the system keys set via the configuration API DSL or an empty
      # hash if none were redefined.
      #
      # @return [Hash]
      def system_key_options
        @_system_key_options ||= Configuration.default_system_keys
      end

      # Checks that the value provided to {#colour_mode} is valid.
      #
      # @param value [Fixnum]
      # @return [Boolean]
      def valid_colour_mode?(value)
        value.is_a?(Fixnum) && [8, 16, 256, 16777216].include?(value)
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

        (value.is_a?(String) || value.is_a?(Symbol)) && defined_value?(value)
      end

      # Raises an exception on behalf of the calling method to report that the
      # value provided is not valid.
      #
      # @param system_key [String] The calling method wishing to raise an
      #   exception.
      # @raise [InvalidSyntax] When the system_key parameter is not a String or
      #   Symbol.
      # @return [InvalidSyntax]
      def invalid_key(system_key)
        fail InvalidSyntax, "`#{system_key}` must be a String or a Symbol."
      end

    end # API

  end # Configuration

end # Vedeu
