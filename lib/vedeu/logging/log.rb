# frozen_string_literal: true

module Vedeu

  module Logging

    # Provides the ability to log anything to the Vedeu log file.
    #
    # @!macro [new] vedeu_logging_log_param_message
    #    @param message [String] The message you wish to emit, useful
    #      for debugging.
    #
    # @api public
    #
    class Log

      class << self

        # @api private
        # @!attribute [rw] count
        # @return [Integer] Used by tests to access the `count`
        #   instance variable.
        attr_accessor :count

        # Used by {Vedeu::Events::Trigger} to indent log messages to
        # show activity which occurs as part of that event triggering.
        #
        # @api private
        # @macro param_block
        # @return [NilClass|void]
        def indent(&block)
          @count ||= 0
          @count += 1

          yield if block_given?
        ensure
          outdent
        end

        # Write a message to the Vedeu log file.
        #
        # @example
        #   Vedeu.log(type:    :debug,
        #             message: 'A useful debugging message: Error!')
        #
        # @macro vedeu_logging_log_param_message
        # @param type [Symbol] Colour code messages in the log file
        #   depending on their source. See {Vedeu::LOG_TYPES}
        #
        # @return [String]
        def log(message:, type: :info)
          if Vedeu.config.loggable?(type)
            output = log_entry(type, message)
            logger.debug(output)
            output
          end
        end

        # {include:file:docs/dsl/by_method/log_stdout.md}
        # @macro vedeu_logging_log_param_message
        # @param type [Symbol] See {Vedeu::LOG_TYPES} for valid
        #   values.
        # @return [String]
        def log_stdout(message:, type: :info)
          log(message: message, type: type)

          $stdout.puts log_entry(type, message)
        end

        # {include:file:docs/dsl/by_method/log_stderr.md}
        # @macro vedeu_logging_log_param_message
        # @param type [Symbol] See {Vedeu::LOG_TYPES} for valid
        #   values.
        # @return [String]
        def log_stderr(message:, type: :error)
          log(message: message, type: type)

          $stderr.puts log_entry(type, message)
        end

        # Used by {Vedeu::Events::Trigger} to outdent log messages to
        # show activity which occurs as part of the previous event
        # triggering.
        #
        # @api private
        # @macro param_block
        # @return [void]
        def outdent(&block)
          result = yield if block_given?

          if @count && @count.positive?
            @count -= 1
          else
            @count = 0
          end

          result
        end

        # {include:file:docs/dsl/by_method/log_timestamp.md}
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
        alias log_timestamp timestamp

        private

        # @param type [Symbol] The type of log message.
        # @return [Array<Symbol>]
        def colours(type)
          Vedeu::LOG_TYPES.fetch(type, [:default, :default])
        end

        # {include:file:docs/dsl/by_method/log_timestamp.md}
        # @macro vedeu_logging_log_param_message
        # @return [String]
        def formatted_message(message)
          "#{timestamp}#{message}\n" if message
        end

        # @return [String]
        def indentation
          ' ' * (@count ||= 0) * 2
        end

        # Returns the message:
        #
        #     [type] message
        #
        # @param type [Symbol] The type of log message.
        # @macro vedeu_logging_log_param_message
        # @return [String]
        def log_entry(type, message)
          log_type(type) + log_message(type, message)
        end

        # @param type [Symbol] The type of log message.
        # @return [String]
        def log_type(type)
          Vedeu.esc.colour(colours(type)[0]) { "[#{type}]".ljust(11) }
        end

        # @param type [Symbol] The type of log message.
        # @macro vedeu_logging_log_param_message
        # @return [String]
        def log_message(type, message)
          Vedeu.esc.colour(colours(type)[1]) { indentation + message }
        end

        # @return [Boolean]
        def logger
          MonoLogger.new(Vedeu.config.log).tap do |log|
            log.formatter = proc do |_, _, _, message|
              formatted_message(message)
            end
          end
        end

      end # Eigenclass

    end # Log

  end # Logging

  # @api public
  # @!method indent
  #   @see Vedeu::Logging::Log.indent
  # @api public
  # @!method log
  #   @see Vedeu::Logging::Log.log
  # @api public
  # @!method log_stdout
  #   @see Vedeu::Logging::Log.log_stdout
  # @api public
  # @!method log_stderr
  #   @see Vedeu::Logging::Log.log_stderr
  # @api public
  # @!method log_timestamp
  #   @see Vedeu::Logging::Log.log_timestamp
  # @api public
  # @!method outdent
  #   @see Vedeu::Logging::Log.outdent
  def_delegators Vedeu::Logging::Log,
                 :indent,
                 :log,
                 :log_stdout,
                 :log_stderr,
                 :log_timestamp,
                 :outdent

end # Vedeu
