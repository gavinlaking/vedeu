module Vedeu

  # This class currently provides the means to trace each method call which
  # occurs inside Vedeu. This is very useful (to me!) for debugging. Running
  # this will make your application less responsive, and the tests
  # excruciatingly slow to run.
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

    # @return []
    def trace
      set_trace_func proc { |event, file, line, id, binding, classname|
        if event == watched && classname.to_s.match(klass)
          Vedeu.log(sprintf(" %s %-35s #%s", event, classname, id))
          # binding.eval('local_variables').each do |var|
          #   print("#{var.to_s} = #{binding.local_variable_get(var).inspect}\n")
          # end
        end
      }
    end

    private

    # @api private
    # @return [String]
    def watched
      options[:event]
    end

    # @api private
    # @return [Regexp]
    def klass
      options[:klass]
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
        event: 'call',
        klass: /^Vedeu::(?!.*Log|Interface|Line|Stream|Style|Colour|Geometry|Terminal|Esc|ColourTranslator).*/
      }
    end

    # everything except Interface, Geometry and Terminal
    # klass: /^Vedeu::(?!.*Interface|Geometry|Terminal).*/
  end
  # :nocov:
end
