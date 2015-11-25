module Vedeu

  module Logging

    # Provides the ability to log anything to the Vedeu log file.
    #
    class Log

      class << self

        # Write a message to the Vedeu log file.
        #
        # @example
        #   Vedeu.log(type:    :debug,
        #             message: 'A useful debugging message: Error!')
        #
        # @param message [String] The message you wish to emit to the
        #   log file, useful for debugging.
        # @param force [Boolean] When evaluates to true will attempt
        #   to write to the log file regardless of the Configuration
        #   setting.
        # @param type [Symbol] Colour code messages in the log file
        #   depending on their source. See {message_types}
        #
        # @return [TrueClass]
        def log(message:, force: false, type: :info)
          output = log_entry(type, message)

          if (enabled? || force) && (Vedeu::Configuration.log_only.empty? ||
                     Vedeu::Configuration.log_only.include?(type))
            logger.debug(output)
          end

          output
        end

        # Write a message to STDOUT.
        #
        # @example
        #   Vedeu.log_stdout
        #
        # @return [TrueClass]
        def log_stdout(type: :info, message:)
          $stdout.puts log_entry(type, message)
        end

        # Write a message to STDERR.
        #
        # @example
        #   Vedeu.log_stderr
        #
        # @return [TrueClass]
        def log_stderr(type: :info, message:)
          $stderr.puts log_entry(type, message)
        end

        # Returns a formatted timestamp.
        # eg. [137.7824]
        #
        # @return [String]
        def timestamp
          @now  = Vedeu.clock_time
          @time ||= 0.0
          @last ||= @now

          unless @last == @time
            @time += (@now - @last).round(4)
            @last = @now
          end

          "[#{format('%7.4f', @time.to_s)}] ".rjust(7)
        end
        alias_method :log_timestamp, :timestamp

        private

        # @return [TrueClass]
        def logger
          MonoLogger.new(log_file).tap do |log|
            log.formatter = proc do |_, _, _, message|
              formatted_message(message)
            end
          end
        end

        # Returns the message with timestamp.
        #
        #    [ 0.0987] [debug]  Something happened.
        #
        # @param message [String] The message type and message
        #   coloured and combined.
        # @return [String]
        def formatted_message(message)
          "#{timestamp}#{message}\n".freeze if message
        end

        # Returns the message:
        #
        #     [type] message
        #
        # @param type [Symbol] The type of log message.
        # @param message [String] The message you wish to emit to the
        #   log file, useful for debugging.
        # @return [String]
        def log_entry(type, message)
          "#{message_type(type)}#{message_body(type, message)}".freeze
        end

        # Fetches the filename from the configuration.
        #
        # @return [String]
        def log_file
          Vedeu::Configuration.log
        end
        alias_method :enabled?, :log_file

        # Displays the message body using the colour specified in the
        # last element of {message_types}.
        #
        # @param type [Symbol] The type of log message.
        # @param body [String] The log message itself.
        # @return [String]
        def message_body(type, body)
          Vedeu::EscapeSequences::Esc
            .send(message_types.fetch(type, :default)[-1]) do
            body
          end
        end

        # Displays the message type using the colour specified in the
        # first element of {message_types}.
        #
        # @param type [Symbol] The type of log message.
        # @return [String]
        def message_type(type)
          Vedeu::EscapeSequences::Esc
            .send(message_types.fetch(type, :default)[0]) do
            "[#{type}]".ljust(11)
          end
        end

        # The defined message types for Vedeu with their respective
        # colours. When used, produces a log entry of the format:
        #
        #     [type] message
        #
        # The 'type' will be shown as the first colour defined in the
        # value array, whilst the 'message' will be shown using the
        # last colour.
        #
        # Valid types available:
        #
        #     :config, :create, :debug, :error, :drb, :event, :info,
        #     :input, :output, :reset, :store, :test, :timer, :update
        #
        # @return [Hash<Symbol => Array<Symbol>>]
        def message_types
          {
            create: [:light_cyan, :cyan],
            store:  [:light_cyan, :cyan],
            update: [:light_cyan, :cyan],
            reset:  [:light_cyan, :cyan],

            event:  [:light_magenta, :magenta],

            timer:  [:light_blue, :blue],

            info:   [:white, :light_grey],
            test:   [:white, :light_grey],
            debug:  [:white, :light_grey],

            input:  [:light_yellow, :yellow],

            compress: [:white, :light_grey],
            output:   [:light_green, :green],
            render:   [:light_green, :green],

            error:  [:light_red, :red],

            config: [:light_blue, :blue],
            dsl:    [:light_blue, :blue],
            editor: [:light_blue, :blue],
            drb:    [:light_blue, :blue],
          }
        end

      end # Eigenclass

    end # Log

  end # Logging

  # @!method log
  #   @see Vedeu::Logging::Log.log
  # @!method log_stdout
  #   @see Vedeu::Logging::Log.log_stdout
  # @!method log_stderr
  #   @see Vedeu::Logging::Log.log_stderr
  # @!method log_timestamp
  #   @see Vedeu::Logging::Log.log_timestamp
  def_delegators Vedeu::Logging::Log,
                 :log,
                 :log_stdout,
                 :log_stderr,
                 :log_timestamp

  # :nocov:

  # See {file:docs/events/system.md#\_log_}
  Vedeu.bind(:_log_) { |msg| Vedeu.log(type: :debug, message: msg) }

  # :nocov:

end # Vedeu
