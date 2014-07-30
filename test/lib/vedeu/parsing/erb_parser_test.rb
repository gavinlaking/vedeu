require 'test_helper'
require 'vedeu/parsing/erb_parser'
require 'vedeu/support/helpers'

class UserView
  def initialize
    @output = ''
  end

  def value
    'Testing Vedeu.'
  end
end

module Vedeu
  describe ERBParser do
    describe '.parse' do
      it 'parses the template when the template file was found' do
        skip
        attributes = {
          object: UserView.new,
          path:   'test/support/template.erb'
        }
        parser = ERBParser.parse(attributes)
        parser.must_equal("This is the test template.\n\n\e[38;5;55mTesting Vedeu.\n\e[48;5;226mTesting Vedeu.\n\e[38;5;208m\e[48;5;226mTesting Vedeu.\n\e[4mTesting Vedeu.\n\nSome more content...\n")
      end

      it 'raises an exception when the template file cannot be found' do
        attributes = {
          object: UserView.new,
          path:   '/some/wrong/path/template.erb'
        }
        proc { ERBParser.parse(attributes) }.must_raise(Errno::ENOENT)
      end
    end
  end
end
