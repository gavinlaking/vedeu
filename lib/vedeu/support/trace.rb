module Vedeu

  # :nocov:
  # This class currently provides the means to trace each method call which
  # occurs inside Vedeu. This is very useful (to me!) for debugging. Running
  # this will make your application less responsive, and the tests
  # excruciatingly slow to run.
  class Trace

    # @todo
    #   Replace this class with this:
    #
    # def self.trace
    #   trace = TracePoint.new(:call) do |tp|
    #     if tp.defined_class.to_s.match(/Troo/)
    #       Vedeu.log(type: :debug,
    #                 message: [tp.defined_class.to_s,
    #                           tp.method_id.to_s].join(' '))
    #     end
    #   end
    #   trace.enable
    # end

    # @param options [Hash]
    # @option option event [Symbol]
    # @option option trace [Boolean]
    # @return [void]
    def self.call(options = {})
      new(options).trace
    end

    # Returns a new instance of Vedeu::Trace
    #
    # @param options [Hash]
    # @return [Trace]
    def initialize(options = {})
      @options = options
    end

    # Performs the trace operation. Building strings which include:
    # - (class_count) a count of classes registered with Vedeu,
    # - (classname) the class name being traced,
    # - (id) the method name being traced,
    # - (vars) any local variables belonging to the method.
    #
    # @note
    #   Arguments to set_trace_func proc:
    #     |event, file, line, id, binding, name|
    #
    # @todo Deprecate, and use TracePoint instead.
    #
    # @return [NilClass|String]
    def trace
      set_trace_func proc { |event, _, _, id, binding, name|
        if event == watched && id != :log && classes.include?(name.to_s)
          vars = variables(binding)

          if vars.empty?
            log_this(format('%s %-25s #%-20s', count, name, id))

          else
            log_this(format("%s %-25s #%-20s\n%s\n", count, name, id, vars))

          end
        end
      } if trace?
    end

    private

    # Writes the message to the log file.
    #
    # @param message [String]
    # @return [String]
    def log_this(message)
      Vedeu::Log.logger.debug(message)

      message
    end

    # Provides inspection of the local variables set within the method being
    # traced. Makes the log file extremely noisy, but very useful for hunting
    # down bugs.
    #
    # @param binding [Class]
    # @return [String]
    def variables(binding)
      binding.eval('local_variables').each do |var|
        variable = Vedeu::Esc.green { var.to_s }
        value    = binding.local_variable_get(var)
        klass    = Vedeu::Esc.magenta { value.class.to_s }
        output   = (value.is_a?(Proc)) ? '#<Proc:...' : value.inspect
        content  = colour(value.class.to_s, output)

        format('%33s %-10s = %s %s', ' ', variable, klass, content)
      end.join("\n")
    end

    # @return [String]
    def watched
      options[:event]
    end

    # @return [Boolean]
    def trace?
      options[:trace]
    end

    # @return [Hash]
    def options
      defaults.merge!(@options)
    end

    # The default values for a new instance of this class.
    #
    # @return [Hash]
    def defaults
      {
        trace: Vedeu::Configuration.trace?,
        event: 'call',
      }
    end

    # @return [Hash]
    def colour(klass, output)
      {
        'Array'    => :yellow,
        'Fixnum'   => :cyan,
        'Hash'     => :blue,
        'NilClass' => :red,
        'String'   => :green,
        'Symbol'   => :magenta,
      }.fetch(klass, :white) { |colour| Vedeu::Esc.send(colour) { output } }
    end

    # Returns the number of Vedeu classes/modules. (Useful for debugging.)
    #
    # @return [String]
    def count
      @count ||= "(#{classes.size}/#{vedeu_classes.size})"
    end

    # Returns the classes to be traced, without exceptions or ignored classes.
    #
    # @return [Set]
    def classes
      @classes ||= vedeu_classes - vedeu_exceptions - ignored_classes
    end

    # Returns all the classes defined within Vedeu.
    #
    # @return [Set]
    def vedeu_classes
      @vedeu_classes ||= Vedeu.constants.collect do |c|
        Vedeu.const_get(c).to_s
      end.to_set
    end

    # Returns all the exceptions defined within Vedeu.
    #
    # @todo Vedeu should produce this set.
    #
    # @return [Set]
    def vedeu_exceptions
      Vedeu::EXCEPTIONS.to_set
    end

    # Returns a set of classes to ignore during tracing.
    #
    # @todo Make this configurable at runtime.
    #
    # @return [Set]
    def ignored_classes
      Set.new [
        'Vedeu::Coercions',
        'Vedeu::Colour',
        'Vedeu::Common',
        'Vedeu::Configuration',
        'Vedeu::Esc',
        'Vedeu::Event',
        'Vedeu::Geometry',
        'Vedeu::Log',
        'Vedeu::Position',
        'Vedeu::Presentation',
        'Vedeu::Repository',
        'Vedeu::Stream',
        'Vedeu::Style',
        'Vedeu::Terminal',
        'Vedeu::Trace',
        'Vedeu::Translator',
      ]
    end

  end # Trace
  # :nocov:

end # Vedeu
