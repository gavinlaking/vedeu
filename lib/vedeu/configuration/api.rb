module Vedeu

  module Configuration

    # The Configuration::API class parses client application configuration into
    # options used by Vedeu to affect certain behaviours.
    class API

      include Vedeu::Common

      # Configure Vedeu via a simple configuration API DSL. Options set here
      # override the default Vedeu configuration set in
      # {Vedeu::Configuration.defaults}
      #
      # @param block [Proc]
      # @return [Hash]
      def self.configure(&block)
        new(&block).configuration
      end

      def initialize(&block)
        instance_eval(&block) if block_given?
      end

      def configuration
        options
      end

      def interactive(value = true)
        options[:interactive] = value
      end

      def standalone(value = true)
        options[:interactive] = !value
      end
      alias_method :noninteractive, :standalone

      def once(value = true)
        options[:once] = value
      end
      alias_method :runonce, :once

      def many(value = true)
        options[:once] = !value
      end

      def terminal_mode(value)
        fail InvalidSyntax,
          '`terminal_mode` must be `cooked` or `raw`.' unless valid_mode?(value)

        options[:terminal_mode] = value
      end

      def cooked
        options[:terminal_mode] = :cooked
      end

      def raw
        options[:terminal_mode] = :raw
      end

      def debug(value = true)
        if options.key?(:trace) && options[:trace] != false
          options[:debug] = true

        else
          options[:debug] = value

        end
      end

      def trace(value = true)
        options[:debug] = true if value === true

        options[:trace] = value
      end

      def colour_mode(value = nil)
        fail InvalidSyntax, '`colour_mode` must be `8`, `16`, `256`, ' \
                            '`16777216`.' unless valid_colour_mode?(value)

        options[:colour_mode] = value
      end

      def exit_key(value)
        return invalid_key('exit_key') unless valid_key?(value)

        options[:system_keys][:exit] = value
      end

      def focus_next_key(value)
        return invalid_key('exit_key') unless valid_key?(value)

        options[:system_keys][:focus_next] = value
      end

      def focus_prev_key(value)
        return invalid_key('exit_key') unless valid_key?(value)

        options[:system_keys][:focus_prev] = value
      end

      def mode_switch_key(value)
        return invalid_key('exit_key') unless valid_key?(value)

        options[:system_keys][:mode_switch] = value
      end

      private

      def options
        @_options ||= {}
      end

      def valid_colour_mode?(value)
        value.is_a?(Fixnum) && [8, 16, 256, 16777216].include?(value)
      end

      def valid_key?(value)
        (value.is_a?(String) || value.is_a?(Symbol)) && defined_value?(value)
      end

      def invalid_key(system_key)
        fail InvalidSyntax, "`#{system_key}` must be a String or a Symbol."
      end

      def valid_mode?(value)
        [:cooked, :raw].include?(value)
      end

    end

  end

end
