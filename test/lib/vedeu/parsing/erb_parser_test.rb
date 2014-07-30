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

  def interface
    'test'
  end

  def path
    'test/support/template.erb'
  end
end

module Vedeu
  describe ERBParser do
    describe '.parse' do
      it 'parses the template when the template file was found' do
        skip
        parser = ERBParser.parse(UserView.new)
        parser.must_equal("This is the test template.\n\n\e[38;5;55mTesting Vedeu.\n\e[48;5;226mTesting Vedeu.\n\e[38;5;208m\e[48;5;226mTesting Vedeu.\n\e[4mTesting Vedeu.\n\nSome more content...\n")
      end

      it 'parses the template when the template file was found' do
        parser = ERBParser.parse(UserView.new)
        parser.must_equal(
          {
            interfaces: [
              {
                name:  "test",
                lines: [
                  {
                    streams: {
                      text: "\e[4mTesting Vedeu."
                    }
                  }, {
                    streams: {
                      text: ""
                    }
                  }, {
                    streams: {
                      text: "Some more content..."
                    }
                  }
                ]
              }
            ]
          }
        )
      end

      it 'raises an exception when the template file cannot be found' do
        user_view = UserView.new
        user_view.stub(:path, '/some/wrong/path/template.erb') do
          proc { ERBParser.parse(user_view) }.must_raise(Errno::ENOENT)
        end
      end
    end
  end
end
