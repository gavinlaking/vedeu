require 'simplecov'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride' unless ENV['NO_COLOR']
require 'minitest/hell'

SimpleCov.start do
  command_name 'MiniTest::Spec'
  add_filter   '/test/'
  add_group    'api',           'vedeu/api'
  add_group    'configuration', 'vedeu/configuration'
  add_group    'cursor',        'vedeu/cursor'
  add_group    'dsl',           'vedeu/dsl'
  add_group    'events',        'vedeu/events'
  add_group    'input',         'vedeu/input'
  add_group    'models/view',   'vedeu/models/view'
  add_group    'models',        'vedeu/models'
  add_group    'output',        'vedeu/output'
  add_group    'presentation',  'vedeu/presentation'
  add_group    'repositories',  'vedeu/repositories'
  add_group    'support',       'vedeu/support'
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
# Minitest::Reporters.use!(
#   # commented out by default (makes tests slower)
#   # Minitest::Reporters::DefaultReporter.new({ color: true, slow_count: 5 }),
#   # Minitest::Reporters::SpecReporter.new
# )

# trace method execution with (optionally) local variables
# require 'vedeu/support/log'
# Vedeu::Trace.call({ watched: 'call', klass: /^Vedeu/ })
