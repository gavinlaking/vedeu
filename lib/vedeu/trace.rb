module Vedeu
  class Trace
    def self.perform(options = {})
      new(options).trace
    end

    def initialize(options = {})
      @options = options
    end

    def trace
      set_trace_func proc { |event, file, line, id, binding, classname|
        if event == watched && classname.to_s.match(klass)
          Vedeu.logger.debug(sprintf(" %s %-30s #%s", event, classname, id))
          # binding.eval('local_variables').each do |var|
          #   print("#{var.to_s} = #{binding.local_variable_get(var).inspect}\n")
          # end
        end
      }
    end

    private

    def pretty!(&block)
      ["\e[38;5;#{rand(22..231)}m", yield, "\e[38;2;39m"].join

    end

    def watched
      options[:event]
    end

    def klass
      options[:klass]
    end

    def options
      defaults.merge!(@options)
    end

    def defaults
      {
        event: 'call',
        klass: /^Vedeu::(?!.*Line|Stream|Style|Colour|Events|Geometry|Terminal|Esc|Translator).*/
      }
    end



    # everything except Interface, Geometry and Terminal
    # /^Vedeu::(?!.*Interface|Geometry|Terminal).*/

    # just Output, Process and Input
    # /^Vedeu::(Output|Process|Input)/

    # /^Vedeu::(?!.*Interface|Colour|Events|Geometry|Terminal|Esc|Translator).*/

  end
end
