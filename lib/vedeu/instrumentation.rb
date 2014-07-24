require 'date'
require 'logger'
require 'ruby-prof'

require 'vedeu'

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
        logger.debug(exception.message + "\n" +
                     exception.backtrace.join("\n"))
      end

      private

      def self.filename
        Vedeu.root_path + '/logs/vedeu.log'
      end
    end

    class Profile
      def self.call(filename = 'profile.html', &block)
        new(filename).profile(&block)
      end

      def initialize(filename)
        @filename = filename
      end

      def profile(&block)
        RubyProf.start

        yield

        result = RubyProf.stop.eliminate_methods!([/^Array/, /^Hash/])

        File.open(filename, 'w') do |file|
          RubyProf::CallStackPrinter.new(result).print(file)
          RubyProf::GraphPrinter.new(result).print(file)
        end
      end

      private

      def filename
        Vedeu.root_path + '/tmp/' + @filename
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
          klass: /^Vedeu::(?!.*Instrumentation|Line|Stream|Style|Colour|Geometry|Terminal|Esc|Translator).*/
        }
      end

      # everything except Interface, Geometry and Terminal
      # klass: /^Vedeu::(?!.*Interface|Geometry|Terminal).*/
    end
  end
end
