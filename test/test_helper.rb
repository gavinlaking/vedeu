require 'simplecov'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride' unless ENV['NO_COLOR']
require 'minitest/hell'

SimpleCov.start do
  command_name 'MiniTest::Spec'
  add_filter   '/test/'
end unless ENV['no_simplecov']

module MiniTest
  class Spec
    # parallelize_me! # uncomment to unleash hell

    class << self
      private

      def describe(desc, *additional_desc, &block)
        stack = Minitest::Spec.describe_stack
        # name  = [stack.last, desc, *additional_desc].compact.join("::")

        klass = [stack.last, desc].join
        name  = [klass, ' ', *additional_desc].compact.join

        sclas = stack.last || if Class === self && is_a?(Minitest::Spec::DSL) then
                                self
                              else
                                Minitest::Spec.spec_type desc, *additional_desc
                              end

        cls = sclas.create name, desc

        stack.push cls
        cls.class_eval(&block)
        stack.pop
        cls
      end
      alias_method :context, :describe

    end # Spec eigenclass

    def assigns(subject, instance_variable, value)
      subject.instance_variable_get(instance_variable).must_equal(value)
    end

    def return_type_for(subject, value)
      fail StandardError, 'value must be a class' unless value.is_a?(Class)

      subject.must_be_instance_of(value)
    end

    def return_value_for(subject, value)
      subject.must_equal(value)
    end
  end
end

require 'mocha/setup'

GC.disable

require 'vedeu'
require 'support/helpers/all'

def test_configuration
  Vedeu::Configuration.reset!

  Vedeu.configure do
    debug!
    colour_mode 16777216
    log         '/tmp/vedeu_test_helper.log'
  end
end

test_configuration


# require 'minitest/reporters'

# module Minitest
#   module Reporters
#     class VedeuReporter < DefaultReporter

#       private

#       def message_for(test)
#         e = test.failure

#         if test.skipped?
#           if @detailed_skip
#             [
#               result_title(:skip, "\nSkipped:"),
#               result_location(:skip, '  ' + "#{location(e)}"),
#               ' ',
#               result_label("Reason: ") + result_reason(e.message),
#               ' ',
#               result_description(test.class.to_s, test.name)
#             ].join("\n")
#           end

#         elsif test.error?
#           [
#             result_title(:error, "\nError:"),
#             result_description(test.class.to_s, test.name),
#             ' ',
#             result_location(:error, '  ' + "#{location(e)}"),
#             ANSI::Code.white('  ' + e.message)
#           ].join("\n")

#         else
#           expect_result, actual_result = e.message.split("\n")
#           _, expect = expect_result.split(":")
#           _, actual = actual_result.split(":")

#           [
#             result_title(:fail, "\nFailure:"),
#             result_location(:fail, '  ' + "#{location(e)}"),
#             ' ',
#             result_label("Expected:") + result_expected(expect),
#             result_label("Actual:  ") + result_actual(actual),
#             ' ',
#             result_description(test.class.to_s, test.name)
#           ].join("\n")

#         end
#       rescue NoMethodError
#         [
#           result_title(:fail, "\nFailure:"),
#           result_location(:fail, '  ' + "#{location(e)}"),
#           ' ',
#           ANSI::Code.white('  ' + e.message),
#           ' ',
#           result_description(test.class.to_s, test.name)
#         ].join("\n")
#       end

#       def result_actual(actual)
#         ANSI::Code.red(actual)
#       end

#       def result_description(klass, testcase)
#         [
#           ANSI::Code.white('  ' + klass),
#           ANSI::Code.white('  ' + testcase),
#         ].join("\n")
#       end

#       def result_expected(expected)
#         ANSI::Code.green(expected)
#       end

#       def result_reason(reason)
#         ANSI::Code.yellow(reason)
#       end

#       def result_title(result, string)
#         underlined = ANSI::Code.underline(string)
#         case result
#         when :fail  then ANSI::Code.red(underlined)
#         when :error then ANSI::Code.red(underlined)
#         when :skip  then ANSI::Code.yellow(underlined)
#         else             ANSI::Code.green(underlined)
#         end
#       end

#       def result_label(string)
#         ANSI::Code.white(ANSI::Code.bright('  ' + string))
#       end

#       def result_location(result, string)
#         bright = ANSI::Code.bright(string)
#         case result
#         when :fail  then ANSI::Code.red(bright)
#         when :error then ANSI::Code.red(bright)
#         when :skip  then ANSI::Code.yellow(bright)
#         else             ANSI::Code.green(bright)
#         end
#       end

#     end
#   end
# end

# Minitest::Reporters.use!(
#   # commented out by default (makes tests slower)
#   # Minitest::Reporters::DefaultReporter.new({ color: true, slow_count: 5 }),
#   # Minitest::Reporters::SpecReporter.new

#   Minitest::Reporters::VedeuReporter.new
# )

# trace method execution with (optionally) local variables
# require 'vedeu/support/log'
# Vedeu::Trace.call({ watched: 'call', klass: /^Vedeu/ })
