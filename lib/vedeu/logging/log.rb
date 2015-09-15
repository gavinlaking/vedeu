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
          "#{timestamp}#{message}\n" if message
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
          "#{message_type(type)}#{message_body(type, message)}"
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
          Vedeu::Esc.send(message_types.fetch(type, :default)[-1]) do
            body
          end
        end

        # Displays the message type using the colour specified in the
        # first element of {message_types}.
        #
        # @param type [Symbol] The type of log message.
        # @return [String]
        def message_type(type)
          Vedeu::Esc.send(message_types.fetch(type, :default)[0]) do
            "[#{type}]".ljust(9)
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
            config: [:light_yellow,  :yellow],
            create: [:light_green,   :green],
            debug:  [:light_red,     :red],
            error:  [:light_red,     :red],
            drb:    [:light_blue,    :blue],
            event:  [:light_magenta, :magenta],
            info:   [:white,         :default],
            input:  [:light_yellow,  :yellow],
            output: [:light_green,   :green],
            reset:  [:light_cyan,    :cyan],
            store:  [:light_cyan,    :cyan],
            test:   [:light_white,   :white],
            timer:  [:light_yellow,  :yellow],
            update: [:light_cyan,    :cyan],
          }
        end

        # Returns a formatted timestamp.
        # eg. [137.7824]
        #
        # @return [String]
        def timestamp
          @now  = Time.now.to_f
          @time = 0.0  unless @time
          @last = @now unless @last

          unless @last == @time
            @time += (@now - @last).round(4)
            @last = @now
          end

          "[#{format('%7.4f', @time.to_s)}] ".rjust(7)
        end

      end # Eigenclass

    end # Log

  end # Logging

end # Vedeu
