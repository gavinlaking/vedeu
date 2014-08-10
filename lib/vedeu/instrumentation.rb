require 'date'
require 'logger'

module Vedeu
  module Instrumentation
    class Log
      def self.logger
        @logger ||= Logger.new(filename).tap do |log|
          log.formatter = proc do |_, time, _, message|
            time.utc.iso8601 + ": " + message + "\n"
          end
        end
      end

      def self.error(exception)
        backtrace = exception.backtrace.join("\n")
        message   = exception.message + "\n" + backtrace

        logger.debug(message)
      end

      private

      def self.filename
        Dir.home + '/.vedeu/vedeu.log'
      end
    end

    class Trace
      def self.call(options = {})
        new(options).trace
      end

      def initialize(options = {})
        @options = options
      end

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
          klass: /^Vedeu::(?!.*Instrumentation|Interface|Line|Stream|Style|Colour|Geometry|Terminal|Esc|ColourTranslator).*/
        }
      end

      # everything except Interface, Geometry and Terminal
      # klass: /^Vedeu::(?!.*Interface|Geometry|Terminal).*/
    end
  end
end
