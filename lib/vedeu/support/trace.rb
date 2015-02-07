require 'vedeu/configuration/configuration'
require 'vedeu/support/esc'
require 'vedeu/support/log'

module Vedeu

  # This class currently provides the means to trace each method call which
  # occurs inside Vedeu. This is very useful (to me!) for debugging. Running
  # this will make your application less responsive, and the tests
  # excruciatingly slow to run.
  #
  # @api private
  class Trace

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
    # - (class_count) a count of classes registered with Vedeu,
    # - (classname) the class name being traced,
    # - (id) the method name being traced,
    # - (vars) any local variables belonging to the method.
    #
    # @todo Deprecate, and use TracePoint instead.
    #
    # @return [NilClass|String]
    def trace
      set_trace_func proc { |event, _file, _line, id, binding, classname|
        if event == watched && id != :log && classes.include?(classname.to_s)
          vars = variables(binding)

          if vars.empty?
            log_this(sprintf("%s %-25s #%-20s",
              class_count, classname, id))

          else
            log_this(sprintf("%s %-25s #%-20s\n%s\n",
              class_count, classname, id, vars))

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
      entries = []
      binding.eval('local_variables').each do |var|
        variable = var.to_s
        value    = binding.local_variable_get(var)
        valclass = value.class.to_s
        output   = (value.is_a?(Proc)) ? '#<Proc:...' : value.inspect

        content  = Esc.send(class_colour.fetch(valclass, :white)) { output }

        entries << sprintf("%33s %-10s = %s %s", " ",
                                                 Esc.green { variable },
                                                 Esc.magenta { valclass },
                                                 content)
      end
      entries.join("\n")
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
      defaults.merge(@options)
    end

    # @return [Hash]
    def defaults
      {
        trace: Vedeu::Configuration.trace?,
        event: 'call',
      }
    end

    # @return [Hash]
    def class_colour
      {
        'Array'    => :yellow,
        'Fixnum'   => :cyan,
        'Hash'     => :blue,
        'NilClass' => :red,
        'String'   => :green,
        'Symbol'   => :magenta,
      }
    end

    # Returns the number of Vedeu classes/modules. (Useful for debugging.)
    #
    # @return [String]
    def class_count
      @_count ||= "(#{classes.size}/#{vedeu_classes.size})"
    end

    # Returns the classes to be traced, without exceptions or ignored classes.
    #
    # @return [Set]
    def classes
      @_classes ||= vedeu_classes - vedeu_exceptions - ignored_classes
    end

    # Returns all the classes defined within Vedeu.
    #
    # @return [Set]
    def vedeu_classes
      @_vedeu_classes ||= Vedeu.constants.collect do |c|
        Vedeu.const_get(c).to_s
      end.to_set
    end

    # Returns all the exceptions defined within Vedeu.
    #
    # @todo Vedeu should produce this set.
    #
    # @return [Set]
    def vedeu_exceptions
      Vedeu::Exceptions.to_set
    end

    # Returns a set of classes to ignore during tracing.
    #
    # @todo Make this configurable at runtime.
    #
    # @return [Set]
    def ignored_classes
      Set.new [
        # 'Vedeu::API',
        # 'Vedeu::Application',
        # 'Vedeu::Background',
        'Vedeu::Coercions',
        'Vedeu::Colour',
        'Vedeu::Translator',
        'Vedeu::Common',
        # 'Vedeu::Composition',
        # 'Vedeu::Compositor',
        'Vedeu::Configuration',
        # 'Vedeu::Cursor',
        # 'Vedeu::Cursors',
        'Vedeu::Esc',
        'Vedeu::Event',
        # 'Vedeu::Focus',
        # 'Vedeu::Foreground',
        'Vedeu::Geometry',
        # 'Vedeu::Grid',
        # 'Vedeu::Input',
        # 'Vedeu::Interface',
        # 'Vedeu::Keymap',
        # 'Vedeu::Launcher',
        # 'Vedeu::Line',
        'Vedeu::Log',
        # 'Vedeu::Menu',
        # 'Vedeu::Menus',
        'Vedeu::Position',
        'Vedeu::Presentation',
        # 'Vedeu::Refresh',
        # 'Vedeu::Render',
        'Vedeu::Repository',
        'Vedeu::Stream',
        'Vedeu::Style',
        'Vedeu::Terminal',
        'Vedeu::Trace',
        # 'Vedeu::View',
        # 'Vedeu::Viewport',
      ]
    end

  end # Trace

end # Vedeu
