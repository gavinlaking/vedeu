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
      alias_method :context, :describe
    end # Spec eigenclass

    def assigns(subject, instance_variable, value)
      subject.instance_variable_get(instance_variable).must_equal(value)
    end

    def return_type_for(subject, value)
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
require 'support/test_classes/all'
require 'support/test_modules/all'

def test_configuration
  Vedeu::Configuration.reset!

  Vedeu.configure do
    debug!
    colour_mode 16777216
    log         '/tmp/vedeu_test_helper.log'
  end
end

test_configuration

# commented out by default (makes tests slower)
# require 'minitest/reporters'
# Minitest::Reporters.use!(
  # Minitest::Reporters::DefaultReporter.new({ color: true, slow_count: 5 }),
  # Minitest::Reporters::SpecReporter.new
# )

# trace method execution with (optionally) local variables
# require 'vedeu/support/log'
# Vedeu::Trace.call({ watched: 'call', klass: /^Vedeu/ })
