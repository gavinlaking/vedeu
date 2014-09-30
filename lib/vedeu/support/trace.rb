module Vedeu

  # This class currently provides the means to trace each method call which
  # occurs inside Vedeu. This is very useful (to me!) for debugging. Running
  # this will make your application less responsive, and the tests
  # excruciatingly slow to run.
  #
  # @api private
  class Trace

    # :nocov:
    # @param options [Hash]
    # @return []
    def self.call(options = {})
      new(options).trace
    end

    # @param options [Hash]
    # @return [Trace]
    def initialize(options = {})
      @options = options
    end

    # Performs the trace operation. Building strings which include:
    # - a count of classes registered with Vedeu,
    # - the class name being traced,
    # - the method name being traced,
    # - any local variables belonging to the method.
    #
    # @return []
    def trace
      set_trace_func proc { |event, file, line, id, binding, classname|
        if event == watched && classes.include?(classname.to_s)
          vars = variables(binding)

          if vars.empty?
            log_this(sprintf("(%s) %s %-25s #%-30s",
              class_count, event, classname, id))

          else
            log_this(sprintf("(%s) %s %-25s #%-30s\n%s\n",
              class_count, event, classname, id, vars))

          end
        end
      } if trace?
    end

    private

    # Writes the message to the log file.
    #
    # @api private
    # @param message [String]
    # @return [Boolean]
    def log_this(message)
      Vedeu::Log.logger.debug(message)
    end

    # Provides inspection of the local variables set within the method being
    # traced. Makes the log file extremely noisy, but very useful for hunting
    # down bugs.
    #
    # @api private
    # @param binding [Class]
    # @return [String]
    def variables(binding)
      entries = []
      binding.eval('local_variables').each do |var|
        variable = var.to_s
        value    = binding.local_variable_get(var)
        output   = (value.is_a?(Proc)) ? '#<Proc:...' : value.inspect

        entries << sprintf("\e[32m%57s %-10s\e[39m= \e[34m%s\e[39m", " ",
                                                                     variable,
                                                                     output)
      end
      entries.join("\n")
    end

    # @api private
    # @return [String]
    def watched
      options[:event]
    end

    # @api private
    # @return [Boolean]
    def trace?
      options[:trace]
    end

    # @api private
    # @return [Hash]
    def options
      defaults.merge!(@options)
    end

    # @api private
    # @return [Hash]
    def defaults
      {
        trace: Vedeu::Configuration.trace?,
        event: 'call',
      }
    end

    # Returns the number of Vedeu classes/modules. (Useful for debugging.)
    #
    # @api private
    # @return [Fixnum]
    def class_count
      classes.size.to_s
    end

    # Returns all the classes defined within Vedeu.
    #
    # @api private
    # @return [Set]
    def classes
      @_classes ||= Vedeu.constants.collect do |c|
        Vedeu.const_get(c).to_s
      end.to_set
    end

  end # Trace
  # :nocov:
end # Vedeu

